import SwiftUI
import UIKit
import Combine

@available(iOS 13.0, *)
final class MapBasicCoordinator {
    typealias ViewportSetter = (Viewport) -> Void

    // Deps
    private let mainQueue: MainQueueProtocol
    private var mapView: MapViewFacade
    private let idleObserver = IdleViewportObserver()

    // Update params
    private var cameraChangeHandlers = [(CameraChanged) -> Void]()
    private var cameraBoundsOptions = CameraBoundsOptions()

    // Runtime variables
    private var currentViewport: Viewport?
    private var updateCameraOnce = Once()
    private var subscribeOnce = Once()
    private var onCameraUpdateInProgress = SignalSubject<Bool>()

    private var cancellables = Set<AnyCancellable>()
    private var shortLivedSubscriptions = Set<AnyCancellable>()

    init(
        setViewport: ViewportSetter?,
        mapView: MapViewFacade,
        mainQueue: MainQueueProtocol = MainQueueWrapper()
    ) {
        self.mapView = mapView
        self.mainQueue = mainQueue

        mapView.mapboxMap.onCameraChanged
            .blockUpdates(while: onCameraUpdateInProgress.signal)
            .observe { [weak self] event in
                for handler in self?.cameraChangeHandlers ?? [] {
                    handler(event)
                }
            }.store(in: &cancellables)

        idleObserver.onIdle = { [weak self] in
            self?.currentViewport = .idle
            setViewport?(.idle)
        }

        mapView.viewportManager.addStatusObserver(idleObserver)
    }

    deinit {
        mapView.viewportManager.removeStatusObserver(idleObserver)
    }

    func update(
        viewport: ConstantOrBinding<Viewport>,
        deps: MapDependencies,
        layoutDirection: LayoutDirection,
        animationData: ViewportAnimationData?
    ) {
        let mapboxMap = mapView.mapboxMap

        groupCameraUpdates(mapboxMap) {
            // Methods in this block can immediately produce multiple `onCameraChanged` notifications.
            // This may trigger SwiftUI's warnings if you save cameraState in @State in response to that camera change like this:
            //
            // @State var cameraState: CameraState
            // Map().onCameraChange { event in cameraState = event.cameraState }
            //
            // To avoid this:
            // 1. the SDK groups the `onCameraChanged` events (by blocking them until the update is in progress); and
            // 2. if the camera is actually changed, posts notification about it in the next runloop.
            //
            // More details are in the `groupCameraUpdates` function.
            updateCamera(position: viewport, layoutDirection: layoutDirection, animationData: animationData)

            assign(self.cameraBoundsOptions, {
                try mapboxMap.setCameraBounds(with: $0)
                self.cameraBoundsOptions = $0
            }, value: deps.cameraBounds)

            let mapOptions = mapView.mapboxMap.options
            assign(mapOptions.constrainMode, mapboxMap.setConstrainMode, value: deps.constrainMode)
            assign(mapOptions.viewportMode ?? .default, mapboxMap.setViewportMode, value: deps.viewportMode)
            assign(mapOptions.orientation, mapboxMap.setNorthOrientation, value: deps.orientation)
        }

        mapView.styleManager.mapStyle = deps.mapStyle
        assign(&mapView, \.gestureManager.options, value: deps.gestureOptions)
        assign(&mapView, \.ornaments.options, value: deps.ornamentOptions)
        assign(&mapView, \.debugOptions, value: deps.debugOptions)
        assign(&mapView, \.presentsWithTransaction, value: deps.presentsWithTransaction)
        assign(&mapView, \.viewportManager.options, value: deps.viewportOptions)

        cameraChangeHandlers = deps.cameraChangeHandlers

        shortLivedSubscriptions.removeAll()

        for subscription in deps.eventsSubscriptions {
            subscription.observe(mapboxMap).store(in: &shortLivedSubscriptions)
        }

        for (layerId, action) in deps.onLayerTap {
            mapView.gestureManager.onLayerTap(layerId, handler: action)
                .store(in: &shortLivedSubscriptions)
        }

        for (layerId, action) in deps.onLayerLongPress {
            mapView.gestureManager.onLayerLongPress(layerId, handler: action)
                .store(in: &shortLivedSubscriptions)
        }

        if let onMapTap = deps.onMapTap {
            mapView.gestureManager.onMapTap
                .observe(onMapTap)
                .store(in: &shortLivedSubscriptions)
        }

        if let onMapLongPress = deps.onMapLongPress {
            mapView.gestureManager.onMapLongPress
                .observe(onMapLongPress)
                .store(in: &shortLivedSubscriptions)
        }
    }

    private func groupCameraUpdates(_ map: MapboxMapProtocol, _ updates: () -> Void) {
        onCameraUpdateInProgress.send(true)
        let cameraBeforeUpdates = map.cameraState
        updates()
        let cameraChanged = map.cameraState != cameraBeforeUpdates
        if cameraChanged {
            // Schedule the update for the next runloop because we want to avoid the
            // "Modifying state during view update" error if the user saves cameraState
            // to a @State property.
            mainQueue.async { [weak self] in
                self?.onCameraUpdateInProgress.send(false)
            }
        } else {
            onCameraUpdateInProgress.send(false)
        }
    }

    private func updateCamera(position: ConstantOrBinding<Viewport>, layoutDirection: LayoutDirection, animationData: ViewportAnimationData?) {
        switch position {
        case .constant(let position):
            updateCameraOnce {
                updateCurrentViewport(viewport: position, layoutDirection: layoutDirection, animationData: nil)
            }
        case .binding(let binding):
            updateCurrentViewport(viewport: binding.wrappedValue, layoutDirection: layoutDirection, animationData: animationData)
        }
    }

    private func updateCurrentViewport(viewport: Viewport, layoutDirection: LayoutDirection, animationData: ViewportAnimationData?) {
        guard viewport != currentViewport else {
            return
        }
        currentViewport = viewport

        guard let state = mapView.makeViewportState(viewport, layoutDirection) else {
            mapView.viewportManager.idle()
            return
        }

        let transition: ViewportTransition
        if let animationData {
            transition = mapView.makeViewportTransition(animationData.animation)
        } else {
            transition = mapView.viewportManager.makeImmediateViewportTransition()
        }

        mapView.viewportManager.transition(to: state, transition: transition, completion: animationData?.completion)
    }
}

private final class IdleViewportObserver: ViewportStatusObserver {
    var onIdle: (() -> Void)?

    func viewportStatusDidChange(from fromStatus: ViewportStatus, to toStatus: ViewportStatus, reason: ViewportStatusChangeReason) {
        switch (fromStatus, toStatus, reason) {
        case (_, .idle, _):
            onIdle?()
        case (_, _, _):
            break
        }
    }
}

// This file is generated.
import UIKit

public struct PolygonAnnotation: Annotation, Equatable {

    /// Identifier for this annotation
    internal(set) public var id: String

    /// The geometry backing this annotation
    public var geometry: Geometry {
        return .polygon(polygon)
    }

    /// The polygon backing this annotation
    public var polygon: Polygon

    /// Toggles the annotation's selection state.
    /// If the annotation is deselected, it becomes selected.
    /// If the annotation is selected, it becomes deselected.
    public var isSelected: Bool = false

    /// Property to determine whether annotation can be manually moved around map
    public var isDraggable: Bool = false

    /// Handles tap gesture on this annotation.
    ///
    /// Should return `true` if the gesture is handled, or `false` to propagate it to the annotations or layers below.
    public var tapHandler: ((MapContentGestureContext) -> Bool)? {
        get { gestureHandlers.tap }
        set { gestureHandlers.tap = newValue }
    }

    /// Handles long press gesture on this annotation.
    ///
    /// Should return `true` if the gesture is handled, or `false` to propagate it to the annotations or layers below.
    public var longPressHandler: ((MapContentGestureContext) -> Bool)? {
        get { gestureHandlers.longPress }
        set { gestureHandlers.longPress = newValue }
    }

    /// Properties associated with the annotation
    public var userInfo: [String: Any]? {
        get { _userInfo?.rawValue as? [String: Any] }
        set {
            let newValue = newValue ?? [:]
            _userInfo = JSONObject(rawValue: newValue)
        }
    }
    private var _userInfo: JSONObject?

    internal var layerProperties: [String: Any] {
        var properties: [String: Any] = [:]
        properties["fill-sort-key"] = fillSortKey
        properties["fill-color"] = fillColor?.rawValue
        properties["fill-opacity"] = fillOpacity
        properties["fill-outline-color"] = fillOutlineColor?.rawValue
        properties["fill-pattern"] = fillPattern
        return properties
    }

    internal var feature: Feature {
        var feature = Feature(geometry: geometry)
        feature.identifier = .string(id)
        var properties = JSONObject()
        properties["layerProperties"] = JSONValue(rawValue: layerProperties)
        if let _userInfo {
            properties["userInfo"] = .object(_userInfo)
        }
        feature.properties = properties
        return feature
    }

    private var gestureHandlers = AnnotationGestureHandlers()

    /// Create a polygon annotation with a `Polygon` and an optional identifier.
    public init(id: String = UUID().uuidString, polygon: Polygon, isSelected: Bool = false, isDraggable: Bool = false) {
        self.id = id
        self.polygon = polygon
        self.isSelected = isSelected
        self.isDraggable = isDraggable
    }

    // MARK: - Style Properties -

    /// Sorts features in ascending order based on this value. Features with a higher sort key will appear above features with a lower sort key.
    public var fillSortKey: Double?

    /// The color of the filled part of this layer. This color can be specified as `rgba` with an alpha component and the color's opacity will not affect the opacity of the 1px stroke, if it is used.
    public var fillColor: StyleColor?

    /// The opacity of the entire fill layer. In contrast to the `fill-color`, this value will also affect the 1px stroke around the fill, if the stroke is used.
    public var fillOpacity: Double?

    /// The outline color of the fill. Matches the value of `fill-color` if unspecified.
    public var fillOutlineColor: StyleColor?

    /// Name of image in sprite to use for drawing image fills. For seamless patterns, image width and height must be a factor of two (2, 4, 8, ..., 512). Note that zoom-dependent expressions will be evaluated only at integer zoom levels.
    public var fillPattern: String?

}

#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
@_spi(Experimental) extension PolygonAnnotation {

    /// Sorts features in ascending order based on this value. Features with a higher sort key will appear above features with a lower sort key.
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public func fillSortKey(_ newValue: Double) -> Self {
        with(self, setter(\.fillSortKey, newValue))
    }

    /// The color of the filled part of this layer. This color can be specified as `rgba` with an alpha component and the color's opacity will not affect the opacity of the 1px stroke, if it is used.
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public func fillColor(_ newValue: StyleColor) -> Self {
        with(self, setter(\.fillColor, newValue))
    }

    /// The opacity of the entire fill layer. In contrast to the `fill-color`, this value will also affect the 1px stroke around the fill, if the stroke is used.
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public func fillOpacity(_ newValue: Double) -> Self {
        with(self, setter(\.fillOpacity, newValue))
    }

    /// The outline color of the fill. Matches the value of `fill-color` if unspecified.
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public func fillOutlineColor(_ newValue: StyleColor) -> Self {
        with(self, setter(\.fillOutlineColor, newValue))
    }

    /// Name of image in sprite to use for drawing image fills. For seamless patterns, image width and height must be a factor of two (2, 4, 8, ..., 512). Note that zoom-dependent expressions will be evaluated only at integer zoom levels.
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public func fillPattern(_ newValue: String) -> Self {
        with(self, setter(\.fillPattern, newValue))
    }


    /// Adds a handler for tap gesture on current annotation.
    ///
    /// The handler should return `true` if the gesture is handled, or `false` to propagate it to the annotations or layers below.
    ///
    /// - Parameters:
    ///   - handler: A handler for tap gesture.
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public func onTapGesture(handler: @escaping (MapContentGestureContext) -> Bool) -> Self {
        with(self, setter(\.tapHandler, handler))
    }

    /// Adds a handler for tap gesture on current annotation.
    ///
    /// - Parameters:
    ///   - handler: A handler for tap gesture.
    #if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public func onTapGesture(handler: @escaping () -> Void) -> Self {
        onTapGesture { _ in
            handler()
            return true
        }
    }

    /// Adds a handler for long press gesture on current annotation.
    ///
    /// The handler should return `true` if the gesture is handled, or `false` to propagate it to the annotations or layers below.
    ///
    /// - Parameters:
    ///   - handler: A handler for long press gesture.
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public func onLongPressGesture(handler: @escaping (MapContentGestureContext) -> Bool) -> Self {
        with(self, setter(\.longPressHandler, handler))
    }

    /// Adds a handler for long press gesture on current annotation.
    ///
    /// - Parameters:
    ///   - handler: A handler for long press gesture.
    #if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public func onLongPressGesture(handler: @escaping () -> Void) -> Self {
        onLongPressGesture { _ in
            handler()
            return true
        }
    }
}

// End of generated file.

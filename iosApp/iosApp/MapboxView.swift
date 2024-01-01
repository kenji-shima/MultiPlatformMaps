import SwiftUI
import shared
import MapboxMaps

var cancelables = Set<AnyCancelable>()
var pointAnnotationManager: PointAnnotationManager!

struct MapViewRepresentable: UIViewRepresentable{
    
    @EnvironmentObject var weatherViewModel: WeatherViewModel
    
    func updateUIView(_ uiView: MapboxMaps.MapView, context: Context) {
        
    }
    
    func makeUIView(context: Context) -> MapView {
        let cameraOptions = CameraOptions(center: CLLocationCoordinate2D(latitude: utils.latitude, longitude: utils.longitude) ,zoom: Utils().initZoom, bearing: 0, pitch: 0)
        
        let mapView = MapView(frame: CGRect(x: 64,y: 64,width: 64,height: 64),
                              mapInitOptions: MapInitOptions(cameraOptions: cameraOptions, styleURI: .streets))
        
        
        mapView.gestures.onMapLongPress.observe {context in
            handleLongTap(mapView: mapView, coordinate: mapView.mapboxMap.coordinate(for: context.point))
        }.store(in: &cancelables)
        
        mapView.mapboxMap.onNext(event: .mapLoaded) { _ in
            try! mapView.mapboxMap.localizeLabels(into: Locale(identifier: "ja"))
            handleLongTap(mapView: mapView, coordinate: CLLocationCoordinate2D(latitude: utils.latitude, longitude: utils.longitude))
        }
        
        return mapView
    }
    
    func handleLongTap(mapView: MapView, coordinate: CLLocationCoordinate2D){
        if(pointAnnotationManager != nil){
            pointAnnotationManager.annotations = []
        }else{
            pointAnnotationManager = mapView.annotations.makePointAnnotationManager()
        }
        var pointAnnotation = PointAnnotation(coordinate: coordinate)
        pointAnnotation.image = .init(image: UIImage(named: "dest-pin")!, name: "dest-pin")
        pointAnnotationManager.annotations = [pointAnnotation]
        weatherViewModel.fetchWeather(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }
    
}

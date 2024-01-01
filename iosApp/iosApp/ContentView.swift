import SwiftUI
import shared

let utils = Utils()

struct ContentView: View {
    
    var body: some View {
        VStack{
            let weatherViewModel = WeatherViewModel()
            MapViewRepresentable().edgesIgnoringSafeArea(.all).environmentObject(weatherViewModel)
            WeatherView().environmentObject(weatherViewModel)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}

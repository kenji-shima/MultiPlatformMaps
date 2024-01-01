import SwiftUI
import shared

struct WeatherView : View {
    let size: CGFloat = 25
    @EnvironmentObject var weatherViewModel: WeatherViewModel
    
    var body: some View{
            HStack{
                if weatherViewModel.isLoading {
                        ProgressView()
                }else if let forecast = weatherViewModel.forecast{
                    VStack{
                        Text(forecast.place)
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack{
                                ForEach(0..<forecast.dateList.count){ index in
                                    VStack(alignment:.leading){
                                        HStack{
                                            Image("calendar").resizable().scaledToFit().frame(width: size, height: size)
                                            Text(forecast.dateList[index])
                                        }
                                        HStack{
                                            Image("temperature-sensor").resizable().scaledToFit().frame(width: size, height: size)
                                            Text(forecast.temperatureList[index])
                                        }
                                        HStack{
                                            Image("drop").resizable().scaledToFit().frame(width: size, height: size)
                                            Text(forecast.precipitationList[index])
                                        }
                                    }
                                    .padding(5)
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(Color.white)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 8)
                                                    .stroke(Color.gray, lineWidth: 1)
                                            )
                                    )
                                    .frame(maxWidth: .infinity)
                                }
                            }
                        }
                    }
                }else if let errorMessage = weatherViewModel.errorMessage{
                    Text("Error: \(errorMessage)")
                }
        }
    }
    
}

class WeatherViewModel : ObservableObject {
    @Published var forecast: ForecastFormatted?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func fetchWeather(latitude: Double, longitude: Double) {
        isLoading = true
        let accessToken = (Bundle.main.object(forInfoDictionaryKey: "MBXAccessToken") as? String)!
        WeatherForecast().asyncGetFormattedWithHandler(lat: latitude, lng: longitude, accessToken: accessToken) { [weak self] (forecast, error) in
            guard let self = self else { return }
            defer { self.isLoading = false }
            
            if let forecast = forecast {
                self.forecast = forecast
            } else if let error = error {
                Logger().error(tag: TAG, message: String(describing: error))
            } else {
                Logger().error(tag: TAG, message: "Unexpected result type")
            }
        }
    }
    
    internal let TAG = "WeatherViewModel"
    
}

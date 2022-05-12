
import Foundation

class WeatherViewModel
{
    var weatherData: [[String:String]]?
    var cloudData: Weather?
    var cityName: String = "Irving"
    
    func getApiData(completion: @escaping(Error?) ->())
    {
        guard let encodedCity = cityName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let weatherURL = URL(string: baseURL + path + encodedCity) else { return }
        APIManager.loadData(forURL: weatherURL) {data, response, error in
            if (error != nil) {
                completion(error)
                return
            }
            do{
                guard let data = data else {
                    completion(error)
                    return
                }
                let jsonDecoder = JSONDecoder()
                let finalData = try!jsonDecoder.decode(CityWeather.self, from: data)
                self.weatherData = self.getCityWeatherData(cityWether: finalData)
                self.cloudData = finalData.weather.first
                self.cityName = finalData.name
                completion(error)
            }
        }
    }
    
    private func getCityWeatherData(cityWether: CityWeather) -> [[String:String]] {
        var displayData =  [[String:String]]()
        displayData.append(["Temprature": String(cityWether.main.temp)])
        displayData.append(["Pressure": String(cityWether.main.pressure)])
        displayData.append(["Humidity": String(cityWether.main.humidity)])
        displayData.append(["Min Temprature": String(cityWether.main.tempMin)])
        displayData.append(["Max Temprature": String(cityWether.main.tempMax)])
        displayData.append(["Wind Speed": String(cityWether.wind.speed)])
        displayData.append(["Wind Speed": String(cityWether.sys.sunset)])
        displayData.append(["Wind Speed": String(cityWether.sys.sunrise)])
        return displayData
    }
}

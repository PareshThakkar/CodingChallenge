import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var tblWeather: UITableView!
    @IBOutlet weak var citySearch: UISearchBar!
    
    var weatherViewModel = WeatherViewModel()
    var searchActive : Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Weather"
        weatherViewModel.getApiData { [weak self] (error) in
            DispatchQueue.main.async {
                if let loadingError = error {
                    self?.displayAlert(loadingError)
                }
                else {
                    self?.tblWeather.reloadData()
                }
            }
        }
    }
    func displayAlert(_ error: Error) {
        Utility.showErrorAlert(with: error.localizedDescription, controller: self)
    }
}

extension WeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let data = weatherViewModel.weatherData {
            return data.count
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let headerCell = self.tblWeather.dequeueReusableCell(withIdentifier: "HeaderCell") as! WeatherHeaderCell
        let weatherDetailCell = self.tblWeather.dequeueReusableCell(withIdentifier: "DetailCell") as! WeatherCell
        if indexPath.row == 0 {
            if let cloudData = weatherViewModel.cloudData{
                headerCell.setData(forCity: weatherViewModel.cityName, cloudData: cloudData)
            }
            return headerCell
        }
        else {
            if let weatherData = weatherViewModel.weatherData {
                weatherDetailCell.setData(data: weatherData[indexPath.row])
            }
            return weatherDetailCell
        }
    }
}

extension WeatherViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 200.0
        }
        else {
            return 60
        }
    }

}
extension WeatherViewController : UISearchBarDelegate
{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let city = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines){
            weatherViewModel.cityName = city
            weatherViewModel.getApiData{ [weak self] (error) in
                DispatchQueue.main.async {
                    if let loadingError = error {
                        self?.displayAlert(loadingError)
                    } else {
                    self?.tblWeather.reloadData()
                    }
                }
            }
        }
        self.citySearch.resignFirstResponder()
    }
}

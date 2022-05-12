
import UIKit

enum SkyStatus: String {
    case broken       = "broken clouds"
    case clear        = "clear sky"
    case clearnight   = "clear night"
    case cloudy       = "cloudy"
    case lightrain    = "light rain"
    case overcast     = "over cast"
    case rain         = "rain"
    case snow         = "snow"
    case sunrain      = "sunrain"
    case thunderstorm = "thunder storm"
}
class WeatherHeaderCell: UITableViewCell {
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblSkyStatus: UILabel!
    @IBOutlet weak var iconCloud: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setData(forCity city: String, cloudData: Weather) {
        lblCity.text = city
        lblSkyStatus.text = cloudData.weatherDescription
        
        let skyStatus = SkyStatus.init(rawValue: cloudData.weatherDescription)
       
        switch skyStatus {
        case .broken:
            iconCloud.image = UIImage(named: "broken")
        case .clear:
            iconCloud.image = UIImage(named: "clear")
        case .clearnight:
            iconCloud.image = UIImage(named: "clearnight")
        case .cloudy:
            iconCloud.image = UIImage(named: "cloudy")
        case .lightrain:
            iconCloud.image = UIImage(named: "lightrain")
        case .overcast:
            iconCloud.image = UIImage(named: "overcast")
        case .rain:
            iconCloud.image = UIImage(named: "rain")
        case .snow:
            iconCloud.image = UIImage(named: "snow")
        case .sunrain:
            iconCloud.image = UIImage(named: "sunrain")
        case .thunderstorm:
            iconCloud.image = UIImage(named: "thunderstorm")
        default:
            iconCloud.image = UIImage(named: "broken")
        }
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}


import UIKit

class WeatherCell: UITableViewCell {
    @IBOutlet weak var lblItem: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func setData(data:[String:String]) {
        lblItem.text = data.keys.first
        lblDesc.text = data.values.first
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

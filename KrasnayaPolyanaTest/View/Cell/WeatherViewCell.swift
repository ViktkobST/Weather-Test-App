//
//  WeatherViewCell.swift
//  KrasnayaPolyanaTest
//
//  Created by Виктор Кобыхно on 1/4/21.
//

import UIKit

class WeatherViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
    }
    
    private func getIcon(_ name: String) -> UIImage {
        var image = UIImage()
        switch name {
        case "Clouds":
            image = UIImage(systemName: "cloud")!
        case "Snow":
            image = UIImage(systemName: "cloud.snow")!
        case "Clear sky":
            image = UIImage(systemName: "sun.max.fill")!
        case "Few clouds":
            image = UIImage(systemName: "cloud.sun")!
        case "Scattered clouds":
            image = UIImage(systemName: "cloud.fog")!
        case "Broken clouds":
            image = UIImage(systemName: "cloud.fill")!
        case "Shower rain":
            image = UIImage(systemName: "cloud.heavyrain")!
        case "Thunderstorm":
            image = UIImage(systemName: "cloud.bolt.rain")!
        case "Mist":
            image = UIImage(systemName: "cloud.fog.fill")!
        default:
            image = UIImage(systemName: "sun.min")!
        }
        return image
    }
    
    public func configureCell(_ weather: WeatherList) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: +0)
        let date = dateFormatter.date(from: weather.dt_txt) ?? Date()
        dateFormatter.dateFormat = "EEE, d MMM yyyy"
        self.dateLabel?.text = dateFormatter.string(from: date)
        dateFormatter.dateFormat = "HH:mm"
        self.timeLabel?.text = "Время: \(dateFormatter.string(from: date))"
        self.temperatureLabel?.text = "\(weather.main.temp)°"
        if weather.main.temp > 0 {
            self.temperatureLabel.textColor = UIColor.green
        } else {
            self.temperatureLabel.textColor = UIColor.red
        }
        self.weatherImage?.image = self.getIcon(weather.weather[0].main)
        self.minTemperatureLabel?.text = "\(weather.main.temp_min)°"
        self.maxTemperatureLabel?.text = "\(weather.main.temp_max)°"
    }
    
}

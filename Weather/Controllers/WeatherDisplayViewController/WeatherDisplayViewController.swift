//
//  WeatherDisplayViewController.swift
//  Weather
//
//  Created by Андрей on 19.02.2021.
//

import UIKit

class WeatherDisplayViewController: UIViewController {
    
    @IBOutlet weak var temperatureLabelOutlet: UILabel!
    @IBOutlet weak var imageWeatherOutlet: UIImageView!
    
    var weather: WeatherCity? {
        didSet {
            let iconUrl = URL(string: "https://openweathermap.org/img/w/" + (weather?.weather.first?.icon ?? "") + ".png")
            if let imageData = try? Data(contentsOf: iconUrl!) {
                self.temperatureLabelOutlet.text = "\(self.weather?.main.temp ?? 0)ºC"
                self.imageWeatherOutlet.image = UIImage(data: imageData)!
            }
        }
    }
    
}

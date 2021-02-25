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
    
    var city: ((String?) -> ())?
    
    var weather: WeatherCity? {
        didSet {
            let iconUrl = URL(string: "https://openweathermap.org/img/w/" + (weather?.weather.first?.icon ?? "") + ".png")
            if let imageData = try? Data(contentsOf: iconUrl!) {
                DispatchQueue.main.async {
                    self.temperatureLabelOutlet.text = "\(Int(self.weather?.main.temp ?? 0))ºC"
                    self.imageWeatherOutlet.image = UIImage(data: imageData)!
                }
            }
        }
    }
    
    @IBAction func addCityWeather(_ sender: UIButton) {
        addCity()
    }
    
    @IBAction func editCityWeatherButtonAction(_ sender: UIButton) {
        
        let editVC = storyboard?.instantiateViewController(withIdentifier: "EditCityViewController") as! EditCityViewController
        editVC.modalPresentationStyle = .fullScreen

        present(editVC, animated: true, completion: nil)
    }
    
}

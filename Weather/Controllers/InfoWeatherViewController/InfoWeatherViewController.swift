//
//  InfoWeatherViewController.swift
//  Weather
//
//  Created by Андрей on 19.02.2021.
//

import UIKit

class InfoWeatherViewController: UIViewController {
    
    @IBOutlet weak var scrollViewOutlet: UIScrollView!
    @IBOutlet weak var stackViewOutlet: UIStackView!
    
    var network = Network()
    var convertTime = ConvertTime()
    var weatherJSON: ((WeatherCity?)->())?
    var weatherDataArray: [String : WeatherCity] = [:]
    let cityArray = ["Minsk", "London", "Moscow"]

    override func viewDidLoad() {
        super.viewDidLoad()

        scrollViewOutlet.delegate = self
        cityWeather(cityArray)
    }

}

//
//  MainScreenViewController.swift
//  Weather
//
//  Created by Андрей on 19.02.2021.
//

import UIKit

var cityArray = UserDefaults.standard.array(forKey: "city") as? [String] ?? [String]()

class MainScreenViewController: UIViewController {
    
    @IBOutlet weak var weatherViewContainer: UIView!
    @IBOutlet weak var infoViewContainer: UIView!
    
    var viewWasLayouted = false

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        if viewWasLayouted == false {
            viewWasLayouted = true
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let weatherDisplayViewController = storyboard.instantiateViewController(withIdentifier: "WeatherDisplayViewController") as! WeatherDisplayViewController
            let infoWeatherViewController = storyboard.instantiateViewController(withIdentifier: "InfoWeatherViewController") as! InfoWeatherViewController
            
            if !cityArray.isEmpty {
                for i in cityArray {
                    infoWeatherViewController.cityWeather(i)
                }
            }
            
            weatherViewContainer.addSubview(weatherDisplayViewController.view)
            weatherDisplayViewController.view.translatesAutoresizingMaskIntoConstraints = false
            infoWeatherViewController.removeCity = { (city) in
                infoWeatherViewController.removeLastElement = cityArray.last
                if infoWeatherViewController.removeLastElement == cityArray.last {
                    cityArray.removeLast()
                    UserDefaults.standard.setValue(cityArray, forKey: "city")
                }
            }
            weatherDisplayViewController.city = { (city) in
                guard let city = city else { return }
                cityArray.append(city)
                UserDefaults.standard.setValue(cityArray, forKey: "city")
                infoWeatherViewController.cityWeather(city)
            }
            NSLayoutConstraint.activate([
                weatherDisplayViewController.view.topAnchor.constraint(equalTo: weatherViewContainer.topAnchor),
                weatherDisplayViewController.view.leftAnchor.constraint(equalTo: weatherViewContainer.leftAnchor),
                weatherDisplayViewController.view.rightAnchor.constraint(equalTo: weatherViewContainer.rightAnchor),
                weatherDisplayViewController.view.bottomAnchor.constraint(equalTo: weatherViewContainer.bottomAnchor)
            ])
            
            infoViewContainer.addSubview(infoWeatherViewController.view)
            infoWeatherViewController.view.translatesAutoresizingMaskIntoConstraints = false
            infoWeatherViewController.weatherJSON = { (weather) in
                    weatherDisplayViewController.weather = weather
            }
            NSLayoutConstraint.activate([
                infoWeatherViewController.view.topAnchor.constraint(equalTo: infoViewContainer.topAnchor),
                infoWeatherViewController.view.leftAnchor.constraint(equalTo: infoViewContainer.leftAnchor),
                infoWeatherViewController.view.rightAnchor.constraint(equalTo: infoViewContainer.rightAnchor),
                infoWeatherViewController.view.bottomAnchor.constraint(equalTo: infoViewContainer.bottomAnchor)
            ])
            
            addChild(weatherDisplayViewController)
            addChild(infoWeatherViewController)
        }
    }
    
}

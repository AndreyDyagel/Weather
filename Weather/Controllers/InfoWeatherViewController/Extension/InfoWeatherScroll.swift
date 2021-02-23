//
//  InfoWeatherScroll.swift
//  Weather
//
//  Created by Андрей on 19.02.2021.
//

import UIKit

extension InfoWeatherViewController {
    
    func cityWeather(_ city: [String]) {
        weatherDataArray.removeAll()
        
        for city in cityArray {
            if let infoCity = Bundle.main.loadNibNamed("CityInfoView", owner: nil, options: nil)?.first as? CityInfoView {
                
                network.networkRequest( "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=a48b233db79278ac59b174cd57b4d091&units=metric&lang=ru") { [weak self] (data) in
                    guard let self = self else { return }
                    
                    let weatherData = try! JSONDecoder().decode(WeatherCity.self, from: data)
                    self.weatherDataArray[city] = weatherData
                    
                    DispatchQueue.main.async {

                        if self.cityArray.firstIndex(of: city) == 0, let weather = self.weatherJSON {
                            weather(weatherData)
                        }
                        
                        infoCity.cityNameLabelOutlet.text = weatherData.name
                        infoCity.weatherDescriptionLabelOutlet.text = "Сейчас: \(weatherData.weather.first?.weatherDescription ?? "")."
                        infoCity.sunriseLabelOutlet.text = "Восход солнца: \(self.convertTime.sunTimeCoverter(timeValue: Double(weatherData.sys.sunrise ?? 0)))"
                        infoCity.sunsetLabelOutlet.text = "Заход солнца: \(self.convertTime.sunTimeCoverter(timeValue: Double(weatherData.sys.sunset ?? 0)))"
                        infoCity.humidityLabelOutlet.text = "Влажность: \(weatherData.main.humidity ?? 0) %"
                        infoCity.speedLabelOutlet.text = "Скорость ветра: \(weatherData.wind.speed ?? 0) м/с"
                        infoCity.feelsLikeLabelOutlet.text = "Ощущается как: \(weatherData.main.feelsLike ?? 0)°C"
                        
                    }
                }
                
                stackViewOutlet.addArrangedSubview(infoCity)
                NSLayoutConstraint.activate([
                    infoCity.heightAnchor.constraint(equalTo: scrollViewOutlet.heightAnchor),
                    infoCity.widthAnchor.constraint(equalTo: scrollViewOutlet.widthAnchor)
                ])
            }
        }
    }
}

//
//  InfoWeatherScroll.swift
//  Weather
//
//  Created by Андрей on 19.02.2021.
//

import UIKit

extension InfoWeatherViewController {
    
    func cityWeather(_ city: String) {
        if let infoCity = Bundle.main.loadNibNamed("CityInfoView", owner: nil, options: nil)?.first as? CityInfoView {
            
            network.networkRequest( "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=a48b233db79278ac59b174cd57b4d091&units=metric&lang=ru") { [weak self] (data) in
                guard let self = self else { return }
                
                if let weatherData = try? JSONDecoder().decode(WeatherCity.self, from: data), weatherData.cod == 200 {
                    
                    DispatchQueue.main.async {
              
                        self.weatherDataArray[self.indexCity] = weatherData
                        if self.indexCity == 0, let weather = self.weatherJSON {
                            weather(weatherData)
                        }
                        self.indexCity += 1
                        infoCity.cityNameLabelOutlet.text = weatherData.name
                        infoCity.weatherDescriptionLabelOutlet.text = "Сейчас: \(weatherData.weather.first?.weatherDescription ?? "")."
                        infoCity.sunriseLabelOutlet.text = "Восход солнца: \(self.convertTime.sunTimeCoverter(timeValue: Double(weatherData.sys.sunrise ?? 0)))"
                        infoCity.sunsetLabelOutlet.text = "Заход солнца: \(self.convertTime.sunTimeCoverter(timeValue: Double(weatherData.sys.sunset ?? 0)))"
                        infoCity.humidityLabelOutlet.text = "Влажность: \(weatherData.main.humidity ?? 0) %"
                        infoCity.speedLabelOutlet.text = "Скорость ветра: \(weatherData.wind.speed ?? 0) м/с"
                        infoCity.feelsLikeLabelOutlet.text = "Ощущается как: \(Int(weatherData.main.feelsLike ?? 0))°C"
                        
                        self.stackViewOutlet.addArrangedSubview(infoCity)
                        NSLayoutConstraint.activate([
                            infoCity.heightAnchor.constraint(equalTo: self.scrollViewOutlet.heightAnchor),
                            infoCity.widthAnchor.constraint(equalTo: self.scrollViewOutlet.widthAnchor)
                        ])
                    }
                    
                } else {
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Ошибка!",
                                                      message: "Город - \(city), не найден!",
                                                      preferredStyle: .alert)
                        let okAcntion = UIAlertAction(title: "Ok",
                                                      style: .default) { [weak self] (_) in
                            guard let self = self else { return }
                            if let removeCity = self.removeCity {
                                removeCity(self.removeLastElement)
                            }
                        }
                        alert.addAction(okAcntion)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
}

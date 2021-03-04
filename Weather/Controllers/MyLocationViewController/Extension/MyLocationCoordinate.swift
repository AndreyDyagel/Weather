//
//  MyLocationCoordinate.swift
//  Weather
//
//  Created by Андрей on 27.02.2021.
//

import UIKit
import CoreLocation

extension MyLocationViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        longitude = location.coordinate.longitude
        latitude = location.coordinate.latitude
        
        network.networkRequest("https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=a48b233db79278ac59b174cd57b4d091&units=metric&lang=ru") { [weak self] (data) in
            guard let self = self else { return }
            
            if let weatherData = try?  JSONDecoder().decode(WeatherCity.self, from: data) {
                
                let iconUrl = URL(string: "https://openweathermap.org/img/w/" + (weatherData.weather.first?.icon ?? "") + ".png")
                
                if let imageData = try? Data(contentsOf: iconUrl!) {
                    
                    DispatchQueue.main.async {
                        
                        self.imageWeatherOutlet.image = UIImage(data: imageData)
                        self.temperatureLabelOutlet.text = "\(Int(weatherData.main.temp ?? 0))°C"
                        self.LocationCityLabelOutlet.text = weatherData.name
                        self.weatherDescriptionLabelOutlet.text = "Сейчас: \(weatherData.weather.first?.weatherDescription ?? "")."
                        self.sunriseLabelOutlet.text = "Восход солнца: \(self.convertTime.sunTimeCoverter(timeValue: Double(weatherData.sys.sunrise ?? 0)))"
                        self.sunsetLabelOutlet.text = "Заход солнца: \(self.convertTime.sunTimeCoverter(timeValue: Double(weatherData.sys.sunset ?? 0)))"
                        self.humidityLabelOutlet.text = "Влажность: \(weatherData.main.humidity ?? 0) %"
                        self.speedLabelOutlet.text = "Скорость ветра: \(weatherData.wind.speed ?? 0) м/с"
                        self.feelsLikeLabelOutlet.text = "Ощущается как: \(Int(weatherData.main.feelsLike ?? 0))°C"
                    }
                    
                }
            }
        }
    }
}


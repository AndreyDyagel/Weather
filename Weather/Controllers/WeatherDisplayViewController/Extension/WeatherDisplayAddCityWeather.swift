//
//  WeatherDisplayAddCityWeather.swift
//  Weather
//
//  Created by Андрей on 24.02.2021.
//

import UIKit

extension WeatherDisplayViewController {
    
    func addCity() {
        
        let alert = UIAlertController(title: nil,
                                      message: "Добавить город:",
                                      preferredStyle: .alert)
        var alertTextField: UITextField!
        let okAction = UIAlertAction(title: "Ok",
                                     style: .default) { [weak self] (_) in
            guard let self = self, let text = alertTextField.text else { return }
            if !text.isEmpty, let city = self.city {
                    city(text)
            } else {
                self.present(alert, animated: true, completion: nil)
            }
        }
        let cancelAction = UIAlertAction(title: "Отмена",
                                         style: .default,
                                         handler: nil)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        alert.addTextField { textField in
            alertTextField = textField
            alertTextField.placeholder = "Город"
            alertTextField.textAlignment = .center
        }
        
        present(alert, animated: true, completion: nil)
    }
}

//
//  InfoWeatherScrollIndex.swift
//  Weather
//
//  Created by Андрей on 23.02.2021.
//

import UIKit

extension InfoWeatherViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let index = Int(scrollView.contentOffset.x / view.frame.width)
        if index < indexCity {
            if let indexCity = weatherJSON {
                indexCity(weatherDataArray[index])
            }
        }
    }
}

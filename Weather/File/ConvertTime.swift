//
//  ConvertTime.swift
//  Weather
//
//  Created by Андрей on 20.02.2021.
//

import UIKit

class ConvertTime {
    
    func sunTimeCoverter(timeValue: Double) -> String {
        let dateAndTime = Date(timeIntervalSince1970: timeValue)
        let dateFormater = DateFormatter()
        dateFormater.timeStyle = .short
        dateFormater.dateFormat = "HH:mm"
        let currentdateAndTime = dateFormater.string(from: dateAndTime as Date)
        return currentdateAndTime
    }
}

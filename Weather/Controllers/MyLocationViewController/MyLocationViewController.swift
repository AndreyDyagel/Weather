//
//  MyLocationViewController.swift
//  Weather
//
//  Created by Андрей on 27.02.2021.
//

import UIKit
import CoreLocation

class MyLocationViewController: UIViewController {
    
    @IBOutlet weak var imageWeatherOutlet: UIImageView!
    @IBOutlet weak var temperatureLabelOutlet: UILabel!
    @IBOutlet weak var LocationCityLabelOutlet: UILabel!
    @IBOutlet weak var sunriseLabelOutlet: UILabel!
    @IBOutlet weak var sunsetLabelOutlet: UILabel!
    @IBOutlet weak var humidityLabelOutlet: UILabel!
    @IBOutlet weak var speedLabelOutlet: UILabel!
    @IBOutlet weak var feelsLikeLabelOutlet: UILabel!
    @IBOutlet weak var weatherDescriptionLabelOutlet: UILabel!
    
    
    var network = Network()
    var convertTime = ConvertTime()
    var locationManager = CLLocationManager()
    var latitude: Double = 0
    var longitude: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.distanceFilter = 10
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()

    }

}

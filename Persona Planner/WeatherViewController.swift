//
//  WeatherViewController.swift
//  Persona Planner
//
//  Created by Gwen Bradforth on 5/4/22.
//

import Foundation
import UIKit
import CoreLocation

class WeatherViewController: UIViewController, CLLocationManagerDelegate {
    let city: String = "Los+Angeles"
    let key = "e40ab40db535077557c11f0a677ff56b"
    var weather:WeatherReader = WeatherReader()
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    
    override func viewDidLoad() {
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()

        locationManager.startUpdatingLocation()
        
        //retrieve weather data using OpenWeather and Core Location
        var url = URL(string: "https://api.openweathermap.org/data/2.5/weather?1=\(city)&appid=\(key)")
        if let loc = locationManager.location {
            url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(loc.coordinate.latitude)&lon=\(loc.coordinate.longitude)&appid=\(key)")
        }
        
        weather.pullJSONData(url: url) { weatherData in
            self.maxLabel.text = String(weatherData.main.temp_max)
            self.minLabel.text = String(weatherData.main.temp_min)
            self.weatherLabel.text = weatherData.weather.main
            
            if (weatherData.weather.main == "Clear")
            {
                self.weatherImage.image = UIImage(named: "sun.png")
            }
            else if (weatherData.weather.main == "Rain")
            {
                self.weatherImage.image = UIImage(named: "rainy.png")
            }
            else if (weatherData.weather.main == "Clouds")
            {
                if (weatherData.weather.main == "few clouds: 11-25%"){
                    self.weatherImage.image = UIImage(named: "cloudy.png")
                }
                else
                {
                    self.weatherImage.image = UIImage(named: "cloud.png")
                }
            }
        }

        
    }
    
}

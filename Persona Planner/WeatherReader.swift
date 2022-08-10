//
//  Weather.swift
//  Persona Planner
//
//  Created by Gwen Bradforth on 5/4/22.
//

import Foundation
import UIKit

class WeatherReader: Decodable{
    
    //various structs to decode JSON
    struct WeatherData: Decodable {
        let list: List
    }
     
    struct Main: Decodable {
        let temp: Float
        let temp_max: Float
        let temp_min: Float
    }
     
    struct Weather: Decodable {
        let main: String
        let description: String
        let icon: String
    }
     
    struct List: Decodable {
        let main: Main
        let weather: Weather
    }
     

    //decode JSONData into a list of weather objects
    func decodeJSONData(JSONData: Data) -> List {
        do {
            let weatherData = try! JSONDecoder().decode(WeatherData.self, from: JSONData)
            return weatherData.list
        }
    }

    //extract JSONData from openweather
    func pullJSONData(url: URL?, completionBlock: @escaping (List) -> Void) -> Void
    {
        var wData:List? = nil
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            if let error = error {
                print(error)
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("Error : HTTP Response code error")
                return
            }
            
            guard let data = data else
            {
                print("No response")
                return
            }
            
            wData = self.decodeJSONData(JSONData: data)
            completionBlock(wData!)
        }
        task.resume()
    }
}

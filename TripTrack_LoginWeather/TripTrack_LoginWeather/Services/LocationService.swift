//
//  LocationService.swift
//  TripTrack_LoginWeather
//
//  Created by Rob C on 2022-04-19.
//

import UIKit

class LocationService {

    let API_KEY = "apikey=ij8qxK4AOxpnXGsz4DgDfQLpjjllUFKw"
    var cityInput = "&q=milton,ontario"
    var detailsInput = "&details=false"
    
    struct LocationModel: Decodable {
        let Key: String
    }


    func getLocationKey(){
        
        // Allows location key value to be stored in AppDelegate
        let mainDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let url = URL(string: "https://dataservice.accuweather.com/locations/v1/cities/search?\(API_KEY)\(cityInput)\(detailsInput)")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
                    if let data = data {
                        if let locationModel = try? JSONDecoder().decode([LocationModel].self, from: data) {
                            print("THIS IS A TEST \n")
                            print(locationModel)
                            DispatchQueue.main.async {
                                // Save response to AppDelegate
                                mainDelegate.locationKey = locationModel[0].Key
                            }
                            
                        } else {
                            print("Invalid Response")
                        }
                    } else if let error = error {
                        print("HTTP Request Failed \(error)")
                    }
                }

                task.resume()
            }
}

import UIKit
import Foundation

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var lblTemp: UILabel?
    @IBOutlet var lblHumidity: UILabel?
    @IBOutlet var lblWind: UILabel?
    @IBOutlet weak var lblCity: UILabel?
    @IBOutlet var tfLat: UITextField?
    @IBOutlet var tfLon: UITextField?
    
    let API_KEY = "appid=133ee0d47ced5bf56acbd5e45eea6dc5"
    var latInput = ""
    var longInput = ""
    var tempMax = "",humid = "",wind = "",country : String = ""
    
    @IBAction func submit() {
        latInput = "lat=" + tfLat!.text!
        longInput = "lon=" + tfLon!.text!
        apiCall()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let _ : [String] = apiCall()
        }
    
    func apiCall() -> [String] {
        
        // MARK: - Welcome
        struct Welcome: Codable {
            let coord: Coord
            let weather: [Weather]
            let base: String
            let main: Main
            let visibility: Int
            let wind: Wind
            let clouds: Clouds
            let dt: Int
            let sys: Sys
            let timezone, id: Int
            let name: String
            let cod: Int
        }

        // MARK: - Clouds
        struct Clouds: Codable {
            let all: Int
        }

        // MARK: - Coord
        struct Coord: Codable {
            let lon, lat: Int
        }

        // MARK: - Main
        struct Main: Codable {
            let temp, feelsLike, tempMin, tempMax: Double
            let pressure, humidity: Int

            enum CodingKeys: String, CodingKey {
                case temp
                case feelsLike = "feels_like"
                case tempMin = "temp_min"
                case tempMax = "temp_max"
                case pressure, humidity
            }
        }

        // MARK: - Sys
        struct Sys: Codable {
            let type, id: Int
            let country: String
            let sunrise, sunset: Int
        }

        // MARK: - Weather
        struct Weather: Codable {
            let id: Int
            let main, weatherDescription, icon: String

            enum CodingKeys: String, CodingKey {
                case id, main
                case weatherDescription = "description"
                case icon
            }
        }

        // MARK: - Wind
        struct Wind: Codable {
            let speed: Double
            let deg: Int
            let gust: Double
        }
        
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?\(latInput)&\(longInput)&\(API_KEY)&units=metric")!
        print(url)
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
                            if let data = data {
                                if let responseEntity = try? JSONDecoder().decode(Welcome.self, from: data) {
                                    //print(responseEntity.main.tempMax)
                                    DispatchQueue.main.async {
                                        self.lblTemp?.text = String(responseEntity.main.tempMax)
                                        self.lblHumidity?.text = String(responseEntity.main.humidity)
                                        self.lblWind?.text = String(responseEntity.wind.speed)
                                        self.lblCity?.text = String(responseEntity.sys.country)
                            }
                        } else {
                            print("Invalid Response")
                        }
                    } else if let error = error {
                        print("HTTP Request Failed \(error)")
                    }
                }

                task.resume()
                return [tempMax,humid,wind,country]
            }
}

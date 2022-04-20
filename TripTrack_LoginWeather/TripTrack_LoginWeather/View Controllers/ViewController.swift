import UIKit

class ViewController: UIViewController {

    let API_KEY = "apikey=ij8qxK4AOxpnXGsz4DgDfQLpjjllUFKw"
    var cityInput = "&q=milton,ontario"
    var detailsInput = "&details=false"



    @IBOutlet weak var lblCity: UILabel?
    @IBOutlet weak var lblTemp: UILabel?
//    @IBOutlet var lblHumidity: UILabel?
//    @IBOutlet var lblWind: UILabel?
//

    override func viewDidLoad() {
        super.viewDidLoad()

        apiCall()
    }

    func apiCall() {
        struct ResponseBody: Decodable {

            // MARK: - Properties

            let Key: String

        }
        let url = URL(string: "https://dataservice.accuweather.com/locations/v1/cities/search?\(API_KEY)\(cityInput)\(detailsInput)")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
                    if let data = data {
                        if let responseEntity = try? JSONDecoder().decode([ResponseBody].self, from: data) {
                            print("THIS IS A TEST \n")
                            print(responseEntity)
                            DispatchQueue.main.async {
                                self.lblCity?.text = responseEntity[0].Key
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
//import UIKit
//
//class ViewController: UIViewController {
//
//    let API_KEY = "apikey=ij8qxK4AOxpnXGsz4DgDfQLpjjllUFKw"
//    var cityInput = "&q=milton,ontario"
//    var detailsInput = "&details=false"
//    let LOCATION_KEY = "49553"
//
//
//
//    @IBOutlet weak var lblCity: UILabel?
//    @IBOutlet weak var lblTemp: UILabel?
////    @IBOutlet var lblHumidity: UILabel?
////    @IBOutlet var lblWind: UILabel?
////
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        apiCall()
//    }
//
//    func apiCall() {
//
//        struct Weather: Decodable {
////            let DailyForecasts: [String]
//            struct DailyForecasts: Decodable{
//                struct Temperature: Decodable {
//
////                       struct Maximum: Decodable {
////                           let Value: String
////                       }
//               }
////            }
//            let temperature: Temperature
//        }
////        struct Weather: Decodable {
//            let dailyForecasts: DailyForecasts
//////
//        }
////
////        struct Temperature: Decodable {
////            let maxValue: [String]
////        }
//
////        /forecasts/v1/daily/1day/55488?apikey=ij8qxK4AOxpnXGsz4DgDfQLpjjllUFKw&details=false&metric=true
//        let url = URL(string: "https://dataservice.accuweather.com/forecasts/v1/daily/1day/49553?apikey=ij8qxK4AOxpnXGsz4DgDfQLpjjllUFKw&details=false&metric=true")!
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//                    if let data = data {
//                        if let responseEntity = try? JSONDecoder().decode(Weather.self, from: data) {
//                            print("THIS IS A TEST \n")
//                            print(responseEntity.dailyForecasts.temperature)
////                            DispatchQueue.main.async {
////                                self.lblCity?.text = responseEntity.temperature.maximum[0]
////                            }
//
//                        } else {
//                            print("Invalid Response")
//                        }
//                    } else if let error = error {
//                        print("HTTP Request Failed \(error)")
//                    }
//                }
//
//                task.resume()
//            }
//
//}

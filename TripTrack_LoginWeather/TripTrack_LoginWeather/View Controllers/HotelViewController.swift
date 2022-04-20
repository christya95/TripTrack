//
//  HotelViewController.swift
//  TripTrack_LoginWeather
//
//  Created by Rob C on 2022-04-20.
//

import UIKit
import WebKit

class HotelViewController: UIViewController, WKNavigationDelegate {
    @IBOutlet var webPage : WKWebView!
    @IBOutlet var activity : UIActivityIndicatorView!
    
    @IBOutlet var btnFlights : UIBarButtonItem!
    @IBOutlet var btnWeather : UIBarButtonItem!
    @IBOutlet var btnHotels : UIBarButtonItem!
    @IBOutlet var btnNews : UIBarButtonItem!
    @IBOutlet var btnFood : UIBarButtonItem!
    @IBOutlet var btnAttractions : UIBarButtonItem!
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activity.isHidden = false
        activity.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activity.isHidden = true
        activity.stopAnimating()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //searchbar.delegate = self
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        let urlAddress = URL(string: "https://www.trivago.ca")
        let url = URLRequest(url: urlAddress!)
        webPage.load(url)
        webPage.navigationDelegate = self
    }

    @IBAction func onRestaurantButtonClick() {
        performSegue(withIdentifier: "hotelToRestaurants", sender: self)
    }
    
    @IBAction func onNewsButtonClick() {
        performSegue(withIdentifier: "hotelToNews", sender: self)
    }
    
    @IBAction func onWeatherButtonClick() {
        performSegue(withIdentifier: "hotelToWeather", sender: self)
    }
    
    @IBAction func onFlightsButtonClick() {
        performSegue(withIdentifier: "hotelToFlights", sender: self)
    }
    
    @IBAction func onAttractionsButtonClick() {
        performSegue(withIdentifier: "hotelToAttractions", sender: self)
    }
    
}

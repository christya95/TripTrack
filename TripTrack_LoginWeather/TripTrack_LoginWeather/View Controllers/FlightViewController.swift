//
//  ViewController.swift
//  Flight_page
//
//  Created by Sean Mapanao on 2022-04-18.
//

import UIKit
import WebKit

class FlightViewController: UIViewController,WKNavigationDelegate {
    
    @IBOutlet var btn : UIButton!
    @IBOutlet var origin : UISearchBar!
    @IBOutlet var destination : UISearchBar!
    @IBOutlet var webView: WKWebView!
    @IBOutlet var activity: UIActivityIndicatorView!
    
    @IBOutlet var btnFlights : UIBarButtonItem!
    @IBOutlet var btnWeather : UIBarButtonItem!
    @IBOutlet var btnHotels : UIBarButtonItem!
    @IBOutlet var btnNews : UIBarButtonItem!
    @IBOutlet var btnFood : UIBarButtonItem!
    @IBOutlet var btnAttractions : UIBarButtonItem!


    let mainDelegate = UIApplication.shared.delegate as! AppDelegate

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
        
        
    }
    
    @IBAction func getParams(sender: UIButton){
        
        var originTxt = origin.text!
        var desTxt = destination.text!
        
        let urlAddress = URL(string: "https://www.google.com/search?q=\(originTxt)+to+\(desTxt)")
        let url = URLRequest(url: urlAddress!)
        webView.load(url)
        webView.navigationDelegate = self
        
    }
    
    @IBAction func onRestaurantButtonClick() {
        performSegue(withIdentifier: "flightsToRestaurants", sender: self)
    }
    
    @IBAction func onNewsButtonClick() {
        performSegue(withIdentifier: "flightsToNews", sender: self)
    }
    
    @IBAction func onWeatherButtonClick() {
        performSegue(withIdentifier: "flightsToWeather", sender: self)
    }
    
    @IBAction func onAttractionsButtonClick() {
        performSegue(withIdentifier: "flightsToAttractions", sender: self)
    }
    
    @IBAction func onHotelsButtonClick() {
        performSegue(withIdentifier: "flightsToHotels", sender: self)
    }
}


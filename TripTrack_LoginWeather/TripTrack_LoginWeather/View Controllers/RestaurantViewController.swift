//
//  RestaurantViewController.swift
//  TripTrack
//
//  Created by Dan Di Clemente on 2022-04-20.
//

import UIKit
import WebKit

class RestaurantViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet var webPage : WKWebView!
    @IBOutlet var activity : UIActivityIndicatorView!
    
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
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        let urlAddress = URL(string: "https://www.yelp.ca")
        let url = URLRequest(url: urlAddress!)
        webPage?.load(url)
        webPage.navigationDelegate = self
    }
    
    
    @IBAction func onNewsButtonClick() {
        performSegue(withIdentifier: "restaurantToNews", sender: self)
    }
    
    @IBAction func onWeatherButtonClick() {
        performSegue(withIdentifier: "restaurantToWeather", sender: self)
    }
    
    @IBAction func onFlightsButtonClick() {
        performSegue(withIdentifier: "restaurantToFlights", sender: self)
    }
    
    @IBAction func onAttractionsButtonClick() {
        performSegue(withIdentifier: "restaurantToAttractions", sender: self)
    }
    
    @IBAction func onHotelsButtonClick() {
        performSegue(withIdentifier: "restaurantToHotels", sender: self)
    }
}

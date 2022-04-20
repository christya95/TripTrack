//
//  AttractionViewController.swift
//  Flight_page
//
//  Created by Sean Mapanao on 2022-04-20.
//

import UIKit
import WebKit

class AttractionViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet var searchTxt : UISearchBar!
    @IBOutlet var webView: WKWebView!
    @IBOutlet var activity: UIActivityIndicatorView!
    
    @IBOutlet var btnFlights : UIBarButtonItem!
    @IBOutlet var btnWeather : UIBarButtonItem!
    @IBOutlet var btnHotels : UIBarButtonItem!
    @IBOutlet var btnNews : UIBarButtonItem!
    @IBOutlet var btnFood : UIBarButtonItem!
    @IBOutlet var btnAttractions : UIBarButtonItem!

    
    //activity indicator start when loading web page
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activity.isHidden = false
        activity.startAnimating()
    }
    
    //activity indicator stop
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activity.isHidden = true
        activity.stopAnimating()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //display webpage
        let urlAddress = URL(string: "https://www.touropia.com/tourist-attractions-in-canada/")
        let url = URLRequest(url: urlAddress!)
        webView.load(url)
        webView.navigationDelegate = self
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onRestaurantButtonClick() {
        performSegue(withIdentifier: "attractionsToRestaurants", sender: self)
    }
    
    @IBAction func onNewsButtonClick() {
        performSegue(withIdentifier: "attractionsToNews", sender: self)
    }
    
    @IBAction func onWeatherButtonClick() {
        performSegue(withIdentifier: "attractionsToWeather", sender: self)
    }
    
    @IBAction func onFlightsButtonClick() {
        performSegue(withIdentifier: "attractionsToFlights", sender: self)
    }
    
    @IBAction func onHotelsButtonClick() {
        performSegue(withIdentifier: "attractionsToHotels", sender: self)
    }
}

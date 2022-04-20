//
//  ViewController.swift
//  TripTrack
//
//  Created by Dan Di Clemente on 2022-04-20.
//

import UIKit

class HomeViewController: UIViewController, UITextViewDelegate, UISearchBarDelegate {

    @IBOutlet var searchbar : UISearchBar!
    
    @IBOutlet var imgToronto : UIImageView!
    @IBOutlet var imgVancouver : UIImageView!
    @IBOutlet var imgBanff : UIImageView!
    @IBOutlet var imgHalifax : UIImageView!
    @IBOutlet var imgYellowknife : UIImageView!
    @IBOutlet var imgMontreal : UIImageView!
    
    @IBOutlet var btnFlights : UIBarButtonItem!
    @IBOutlet var btnWeather : UIBarButtonItem!
    @IBOutlet var btnHotels : UIBarButtonItem!
    @IBOutlet var btnNews : UIBarButtonItem!
    @IBOutlet var btnFood : UIBarButtonItem!
    @IBOutlet var btnAttractions : UIBarButtonItem!
    
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch : UITouch = touches.first!
        let touchPoint : CGPoint = touch.location(in: self.view)
        
        let torontoFrame : CGRect = imgToronto.frame
        let vancouverFrame : CGRect = imgVancouver.frame
        let banffFrame : CGRect = imgBanff.frame
        let halifaxFrame : CGRect = imgHalifax.frame
        let yellowknifeFrame : CGRect = imgYellowknife.frame
        let montralFrame : CGRect = imgMontreal.frame
        
        if (torontoFrame.contains(touchPoint)) {
            mainDelegate.locationSelected = "Toronto, ON"
            performSegue(withIdentifier: "HomeSegueToLocation", sender: self)
        }
        else if (vancouverFrame.contains(touchPoint)) {
            mainDelegate.locationSelected = "Vancouver, BC"
            performSegue(withIdentifier: "HomeSegueToLocation", sender: self)
        }
        else if (banffFrame.contains(touchPoint)) {
            mainDelegate.locationSelected = "Banff, AB"
            performSegue(withIdentifier: "HomeSegueToLocation", sender: self)
        }
        else if (halifaxFrame.contains(touchPoint)) {
            mainDelegate.locationSelected = "Halifax, NS"
            performSegue(withIdentifier: "HomeSegueToLocation", sender: self)
        }
        else if (yellowknifeFrame.contains(touchPoint)) {
            mainDelegate.locationSelected = "Yellowknife, NWT"
            performSegue(withIdentifier: "HomeSegueToLocation", sender: self)
        }
        else if (montralFrame.contains(touchPoint)) {
            mainDelegate.locationSelected = "Montreal, QC"
            performSegue(withIdentifier: "HomeSegueToLocation", sender: self)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchbar.text = ""
        searchbar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        mainDelegate.locationSelected = searchbar.text
        searchbar.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchbar.delegate = self
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    // TODO: IMPLEMENT THE SEGUES FOR THE BOTTOM AND TOP NAVIGATION BARS, ONCE PROJECTS ARE COMBINED
    @IBAction func onRestaurantButtonClick() {
        performSegue(withIdentifier: "homeToRestaurants", sender: self)
    }
    
    @IBAction func onNewsButtonClick() {
        performSegue(withIdentifier: "homeToNews", sender: self)
    }
    
    @IBAction func onWeatherButtonClick() {
        performSegue(withIdentifier: "homeToWeather", sender: self)
    }
    
    @IBAction func onFlightsButtonClick() {
        performSegue(withIdentifier: "homeToFlights", sender: self)
    }
    
    @IBAction func onAttractionsButtonClick() {
        performSegue(withIdentifier: "homeToAttractions", sender: self)
    }
    
    @IBAction func onHotelsButtonClick() {
        performSegue(withIdentifier: "homeToHotels", sender: self)
    }
}


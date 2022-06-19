//
//  SearchLocationViewController.swift
//  My Map
//
//  Created by AmirDiafi on 6/19/22.
//

import UIKit
import MapKit

class SearchLocationViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var searchBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func searchButton(_ sender: Any) {
        let distination = textField.text!
        if distination.count > 0 {
            searchForDistination(searchFor: distination)
        } else {
            showAlert(msg: "no value to search for")
        }
    }
    
    func searchForDistination(searchFor: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(searchFor) { (places, error) in
            guard let places = places, error == nil else {
                self.showAlert(msg: "no places found with this value")
                return
            }
            
            guard let place = places.first else {
                return
            }
            
            let coordination = place.location?.coordinate
            let pin = MKPointAnnotation()
            pin.coordinate = coordination!
            pin.title = place.name
            pin.subtitle = "timezone of \(place.name!) is: \(place.timeZone!)"
            self.mapView.addAnnotation(pin)
            let region = MKCoordinateRegion(center: coordination!, latitudinalMeters: 5000, longitudinalMeters: 5000)
            self.mapView.setRegion(region, animated: true)
            self.textField.text = ""
        }
    }
    
    func showAlert(msg: String) {
        let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

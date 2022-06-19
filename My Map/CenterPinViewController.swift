//
//  CenterPinViewController.swift
//  My Map
//
//  Created by AmirDiafi on 6/19/22.
//

import UIKit
import MapKit
import CoreLocation

class CenterPinViewController: UIViewController, MKMapViewDelegate {

    var prevLocation : CLLocation? = nil
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var pinImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
//        let coords = getUserCoords()
//        setupMapView(location: coords)
    }
    
    func setupMapView(location: CLLocation) {
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        mapView.setRegion(region, animated: true)
    }
    
    func getUserCoords() -> CLLocation {
        let coords = CLLocation(latitude: 13.5, longitude: 0.5)
        return coords
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let newLocation = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
        
        print("distance: \(prevLocation?.distance(from: newLocation))")
        if prevLocation == nil || prevLocation?.distance(from: newLocation) ?? 0 > 100 {
            getRegionInfo(region: newLocation)
        }
    }
    
    func getRegionInfo(region: CLLocation) {
        prevLocation = region
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(region) { (places, error) in
            guard let place = places?.first, error == nil else {
                return
            }
            print("country: \(String(describing: place.country))")
        }
    }

}

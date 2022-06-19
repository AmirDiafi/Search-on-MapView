//
//  SecondMapViewController.swift
//  My Map
//
//  Created by AmirDiafi on 6/19/22.
//

import UIKit
import MapKit
import CoreLocation

class SecondMapViewController: UIViewController, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.allowsBackgroundLocationUpdates = true
        
        if isLocationServiceEnabled() {
            checkAuthorization()
        } else {
            showAlert(msg: "Please enable location service.", type: "authSettings")
        }
    }
    
    func isLocationServiceEnabled() -> Bool {
        return CLLocationManager.locationServicesEnabled()
    }
    
    func checkAuthorization() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
            break
        case .authorizedAlways:
            locationManager.startUpdatingLocation()
            mapView.showsUserLocation = true
            break
        case .authorizedWhenInUse:
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
            mapView.showsUserLocation = true
            break
        case .denied:
            showAlert(msg: "Please authorize ur location service to use.", type: "locationService")
            break
        case .restricted:
            showAlert(msg: "Authorization restricted.", type: nil)
            break
        default:
            showAlert(msg: "Default message.", type: nil)
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
            case .authorizedAlways:
                locationManager.startUpdatingLocation()
                mapView.showsUserLocation = true
                break
            case .authorizedWhenInUse:
                locationManager.requestAlwaysAuthorization()
                locationManager.startUpdatingLocation()
                mapView.showsUserLocation = true
                showAlert(msg: "Aauthorized When In Use", type: nil)
                break
            case .denied:
                print("denied")
                showAlert(msg: "Please authorize ur location service to use.", type: "locationService")
                break
            default:
                showAlert(msg: "no changed", type: nil)
                break
            }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            zoomToUserLocation(location: lastLocation)
            print("lastLocation => \(lastLocation.coordinate)")
        }
    }
    
    func zoomToUserLocation(location: CLLocation) {
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
    }
    
    func showAlert(msg: String, type: String?) {
        let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        if type != nil {
            alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: {action in
                if type == "locationService" {
//                    UIApplication.shared.open(URL(string: "App-prefs:Privacy&path=LOCATION")!)
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                } else if type == "authSettings" {
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                }
            }))
        }
        present(alert, animated: true, completion: nil)
    }

}

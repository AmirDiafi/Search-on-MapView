//
//  ViewController.swift
//  My Map
//
//  Created by AmirDiafi on 6/18/22.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let location = CLLocation(latitude: 35.383060, longitude: 5.368560)
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        let distance = 1000
        setupMapView(location: location, distance: CLLocationDistance(distance))
        addAnnotation()
    }

    func setupMapView(location: CLLocation, distance: CLLocationDistance) {
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: distance, longitudinalMeters: distance)
        mapView.setCameraBoundary(MKMapView.CameraBoundary(coordinateRegion: region), animated: true)
        let zoom = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 5000)
        mapView.setCameraZoomRange(zoom, animated: true)
        mapView.setRegion(region, animated: true)
    }
    
    func addAnnotation() {
        let pin = MKPointAnnotation()
        pin.coordinate = location.coordinate
        pin.title = "My location!"
        pin.subtitle = "My pin subtitle!"
        mapView.addAnnotation(pin)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotation_View = MKAnnotationView()
        let image = UIImage(systemName: "applelogo")
        annotation_View.image = image
        let transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        annotation_View.transform = transform
        return annotation_View
    }
}


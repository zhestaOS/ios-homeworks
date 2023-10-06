//
//  MapViewController.swift
//  Navigation
//
//  Created by Евгения Шевякова on 03.10.2023.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    
    var currentLocation: CLLocationCoordinate2D?
    var currentAnnotation: MKAnnotation?
    var currentOverlay: MKOverlay?
    
    lazy var mapView: MKMapView = {
        let view = MKMapView()
        view.mapType = .standard
        view.showsUserLocation = true
        view.toAutoLayout()
        return view
    }()
    
    lazy var clearButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.backgroundColor = .systemBackground
        button.tintColor = .systemGray
        button.layer.cornerRadius = 21
        button.addTarget(self, action: #selector(clearNavigation), for: .touchUpInside)
        button.isHidden = true
        button.toAutoLayout()
        return button
    }()
    
    lazy var mapTypeSegmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Стандартная", "Спутник", "Гибрид"])
        control.selectedSegmentIndex = 0
        control.addTarget(self, action: #selector(switchMapType), for: .valueChanged)
        control.backgroundColor = .systemBackground
        control.toAutoLayout()
        return control
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupMap()
        setupLocation()
        setupLongTap()
    }
    
    private func setupMap() {
        view.addSubview(mapView)
        view.addSubview(clearButton)
        view.addSubview(mapTypeSegmentedControl)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            clearButton.heightAnchor.constraint(equalToConstant: 42),
            clearButton.widthAnchor.constraint(equalToConstant: 42),
            clearButton.topAnchor.constraint(equalTo: mapTypeSegmentedControl.bottomAnchor, constant: 20),
            clearButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -44),
            
            mapTypeSegmentedControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            mapTypeSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            mapTypeSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
        ])
        
        mapView.delegate = self
        mapView.showsUserLocation = true
    }
    
    private func setupLocation()  {
        self.locationManager.requestWhenInUseAuthorization()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    @objc
    private func switchMapType() {
        switch mapTypeSegmentedControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .satellite
        case 2:
            mapView.mapType = .hybrid
        default:
            print("")
        }
    }
    
    @objc
    func clearNavigation() {
        mapView.removeOverlays(mapView.overlays)
        removePinsWitoutMy()
        clearButton.isHidden = true
    }
    
    private func setupLongTap() {
        let recognizer = UILongPressGestureRecognizer()
        recognizer.minimumPressDuration = 1
        recognizer.addTarget(self, action: #selector(longTapHandled))
        mapView.addGestureRecognizer(recognizer)
    }
    
    private func removePinsWitoutMy() {
        mapView.removeAnnotations(mapView.annotations)
        if let currentAnnotation {
            mapView.addAnnotation(currentAnnotation)
        }
    }
    
    @objc
    private func longTapHandled(recognizer: UIGestureRecognizer) {
        removePinsWitoutMy()
        
        let touchPoint = recognizer.location(in: mapView)
        let touchCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        let destinationPin = MKPointAnnotation()
        destinationPin.coordinate = touchCoordinate
        mapView.addAnnotation(destinationPin)
        
        guard let currentLocation = currentLocation else { return }
        
        let destinationCoordinate = touchCoordinate
        
        let sourcePlacemark = MKPlacemark(coordinate: currentLocation)
        let destinationPlacemark = MKPlacemark(coordinate: destinationCoordinate)
        
        let sourceItem = MKMapItem(placemark: sourcePlacemark)
        let destinationItem = MKMapItem(placemark: destinationPlacemark)
        
        let directionsRequest = MKDirections.Request()
        directionsRequest.source = sourceItem
        directionsRequest.destination = destinationItem
        directionsRequest.transportType = .automobile
        
        let directions = MKDirections(request: directionsRequest)
        directions.calculate { response, error in
            guard
                let response = response,
                    let route = response.routes.first else { return }
            
            self.mapView.addOverlay(route.polyline, level: .aboveRoads)
            self.clearButton.isHidden = false
        }
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            currentOverlay = overlay
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = .purple
            renderer.lineWidth = 3.0
            return renderer
        }
        return MKOverlayRenderer()
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let current: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        
        let latitudeDelta:CLLocationDegrees = 0.01
        let longitudeDelta:CLLocationDegrees = 0.01

        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latitudeDelta, longitudeDelta: longitudeDelta)
        
        let pointLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(current.latitude, current.longitude)

        let region: MKCoordinateRegion = MKCoordinateRegion(center: pointLocation, span: span)
        mapView.setRegion(region, animated: true)
        
        let pinLocation : CLLocationCoordinate2D = CLLocationCoordinate2DMake(current.latitude, current.longitude)
        let objectAnnotation = MKPointAnnotation()
        objectAnnotation.coordinate = pinLocation
        objectAnnotation.title = "My position"
        mapView.addAnnotation(objectAnnotation)
        
        currentLocation = pinLocation
        currentAnnotation = objectAnnotation
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

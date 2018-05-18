//
//  MapViewController.swift
//  ShuttleBus
//
//  Created by Muchamad Chozinul Amri on 17/5/18.
//  Copyright © 2018 Muchamad Chozinul Amri. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var shuttle:Shuttle!
    var activeBusses = [ActiveBus]()
    
    let regionRadius: CLLocationDistance = 5000
    let singaporeCenter = CLLocation(latitude: 1.3521, longitude: 103.8198)
    var annotationList = [MKPointAnnotation]()
    
    let locationManager = CLLocationManager()
    var currentLocation:CLLocationCoordinate2D?
    let refreshRate = 5.0
    var timer:Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        initUI()
        refreshMapAnnotation()
        timer = Timer.scheduledTimer(timeInterval: refreshRate, target: self, selector: #selector(refreshMapAnnotation), userInfo: nil, repeats: true)
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }

    deinit {
        timer?.invalidate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //init map
    func initUI() {
        centerMapOnLocation(location: singaporeCenter.coordinate)
        mapView.delegate = self
    }
    
    //refreshMapAnnotation
    @objc func refreshMapAnnotation(){
        ShuttleBusAPI.GetShuttles(shuttle: shuttle.name!, completion: {
            [weak self] (activeBusListAPI)  in
            if let busses = activeBusListAPI?.activeBusResult?.activeBuses, busses.count > 0 {
                self?.activeBusses = busses
                if self?.currentLocation == nil {
                    self?.centerMapOnLocation(location: CLLocationCoordinate2D(latitude: (busses.first?.lat)!, longitude: (busses.first?.lng)!))
                }
                self?.refreshMap()
            }
        })
    }
    
    //center map
    func centerMapOnLocation(location: CLLocationCoordinate2D) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location,
                                                                  regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    //refresh map
    func refreshMap(){
        mapView.removeAnnotations(annotationList)
        
        if let currentLocation = currentLocation {
            let point = MKPointAnnotation()
            point.title = "You"
            point.subtitle = "Current"
            point.coordinate = currentLocation
            mapView.addAnnotation(point)
            annotationList.append(point)
        }
        
        for bus in activeBusses {
            addAnnotation(bus: bus)
        }
    }
    
    
    func addAnnotation(bus:ActiveBus) {
        guard let lat = bus.lat,
            let lng = bus.lng else {
                return
        }
        let point = MKPointAnnotation()
        point.title = shuttle.name
        point.subtitle = "bus"
        point.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        mapView.addAnnotation(point)
        annotationList.append(point)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard !annotation.isKind(of: MKUserLocation.self) else {
            return nil
        }
        
        let annotationIdentifier = "AnnotationIdentifier"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier)
        if annotationView == nil {
            annotationView = AnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView!.canShowCallout = false
            let image = UIImage(named: "annotation_background")
            annotationView?.image = image
        }else {
            annotationView!.annotation = annotation
        }
        if let annotationV = annotationView as! AnnotationView? {
            annotationV.showTitle(title: annotation.title!!)
            annotationV.showSubtitle(title: annotation.subtitle!!)
        }
        
        return annotationView
    }

}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let _ = locations.last?.coordinate.latitude, let _ = locations.last?.coordinate.longitude {
            if currentLocation != nil {
                currentLocation = locations.last?.coordinate
            }else{
                currentLocation = locations.last?.coordinate
                centerMapOnLocation(location: currentLocation!)
            }
            self.refreshMap()
        } else {
            print("No coordinates")
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

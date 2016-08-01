//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Giovanni Catania on 21/04/16.
//  Copyright © 2016 Giovanni Catania. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    // MARK: - Properties

    var mapView : MKMapView!
    let locationManager = CLLocationManager()
    var locations : [WorldAnnotation]!
    var locationCount : Int = 0
    
    // MARK: - Superclass methods override section

    override func loadView() {
        // setup map obj
        mapView = MKMapView()
        self.view = mapView
        mapView.mapType = .Hybrid
        mapView.delegate = self

        // setup top segmentedControl
        let standardString = NSLocalizedString("Standard", comment: "Standard map view")
        let hybridString = NSLocalizedString("Hybrid", comment: "Hybrid map view")
        let satelliteString = NSLocalizedString("Satellite", comment: "Satellite map view")
        let segmentedControl = UISegmentedControl(items: [standardString, hybridString, satelliteString])
        segmentedControl.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 1
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(segmentedControl)
        let topConstraint = segmentedControl.topAnchor.constraintEqualToAnchor(self.topLayoutGuide.bottomAnchor, constant: 8)
        let margins = self.view.layoutMarginsGuide
        let leadingConstraint = segmentedControl.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor)
        topConstraint.active = true
        leadingConstraint.active = true
        trailingConstraint.active = true
        segmentedControl.addTarget(self, action: #selector(mapTypeChanged(_:)), forControlEvents: .ValueChanged)

        // setup bottom segmentedUserControl
        let offString = NSLocalizedString("Off", comment: "Turn Off user track")
        let trackMeString = NSLocalizedString("Track me", comment: "Tracks user position")
        let headingTrackString = NSLocalizedString("Heading Track", comment: "Head tracks user position")
        let segmentedUserControl = UISegmentedControl(items: [offString, trackMeString, headingTrackString])
        segmentedUserControl.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        segmentedUserControl.selectedSegmentIndex = 0
        segmentedUserControl.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(segmentedUserControl)
        let userBottomConstraint = segmentedUserControl.bottomAnchor.constraintEqualToAnchor(self.bottomLayoutGuide.topAnchor , constant: -8)
        let userLeadingConstraint = segmentedUserControl.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor)
        let userTrailingConstraint = segmentedUserControl.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor)
        userBottomConstraint.active = true
        userLeadingConstraint.active = true
        userTrailingConstraint.active = true
        segmentedUserControl.addTarget(self, action: #selector(userTrackTypeChanged(_:)), forControlEvents: .ValueChanged)
        
        // setup bottom buttonControl
        let buttonControl = UIButton(type: .System)
        buttonControl.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        let showNextString = NSLocalizedString("Show my next Location", comment: "Shows user next location")
        buttonControl.setTitle(showNextString, forState: UIControlState.Normal)
        buttonControl.translatesAutoresizingMaskIntoConstraints=false
        self.view.addSubview(buttonControl)
        let buttonBottomConstraint = buttonControl.bottomAnchor.constraintEqualToAnchor(self.bottomLayoutGuide.topAnchor , constant: -48)
        let buttonLeadingConstraint = buttonControl.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor)
        let buttonTrailingConstraint = buttonControl.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor)
        buttonBottomConstraint.active = true
        buttonLeadingConstraint.active = true
        buttonTrailingConstraint.active = true
        buttonControl.addTarget(self, action: #selector(showNextLocation(_:)), forControlEvents: .TouchDown)
        
        
        // create and add 3 annotations to map
        let birthPlace = WorldAnnotation(title: "Via Ammiraglio Caracciolo 96", subtitle: "Catania", coordinate: CLLocationCoordinate2D(latitude: 37.5077792, longitude: 15.0653242), info: "Where I grown up")
        let currentPlace = WorldAnnotation(title: "Casa Topolla", subtitle: "Contrada Ninfo 49 Motta Sant'Anastasia", coordinate: CLLocationCoordinate2D(latitude: 37.526898, longitude: 14.984134), info: "Attuale casa di Pollo e Topa")
        let vienna = WorldAnnotation(title: "Vienna", subtitle: "Austria", coordinate: CLLocationCoordinate2D(latitude: 48.2059084, longitude: 16.3700393), info: "Interesting location already visited")
        mapView.addAnnotation(birthPlace)
        mapView.addAnnotation(currentPlace)
        mapView.addAnnotation(vienna)
        locations = [birthPlace, currentPlace, vienna]
        locationCount = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MapViewController loaded its view.")
    }

    // MARK: - Actions

    func mapTypeChanged(segContol: UISegmentedControl) {
        switch segContol.selectedSegmentIndex {
        case 0:
            mapView.mapType = .Standard
        case 1:
            mapView.mapType = .Hybrid
        case 2:
            mapView.mapType = .Satellite
        default:
            break
        }
    }

    func userTrackTypeChanged(segContol: UISegmentedControl) {
        switch segContol.selectedSegmentIndex {
        case 0:
            mapView.setUserTrackingMode(MKUserTrackingMode.None, animated: true)
            mapView.showsUserLocation = false
        case 1:
            locationManager.requestWhenInUseAuthorization()
            mapView.setUserTrackingMode(MKUserTrackingMode.Follow, animated: true)
            mapView.showsUserLocation = true
        case 2:
            locationManager.requestWhenInUseAuthorization()
            mapView.setUserTrackingMode(MKUserTrackingMode.FollowWithHeading, animated: true)
            mapView.showsUserLocation = true
        default:
            break
        }
    }

    func showNextLocation(button: UIButton) {
        mapView.showAnnotations([locations[locationCount]], animated: true)
        locationCount += 1
        if locationCount == 3 {
            locationCount = 0
        }
    }
    
    // MARK: - Delegate funcs
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "WorldAnnotation"
        if annotation.isKindOfClass(WorldAnnotation.self) {
            var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
            if annotationView == nil {
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView!.canShowCallout = true
                let btn = UIButton(type: .DetailDisclosure)
                annotationView!.leftCalloutAccessoryView = btn
            } else {
                annotationView!.annotation = annotation
            }
            return annotationView
        }
        return nil
    }

    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl){
        let world = view.annotation as! WorldAnnotation
        let placeName = world.title
        let placeInfo = world.info
        
        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .Alert)
        ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        presentViewController(ac, animated: true, completion: nil)
    }}

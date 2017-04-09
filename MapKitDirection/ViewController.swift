//
//  ViewController.swift
//  MapKitDirection
//
//  Created by Vladyslav Filippov on 02.04.17.
//  Copyright © 2017 Vladyslav Filippov. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController , MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        let sourceLocation = CLLocationCoordinate2DMake(50.358961, 30.432194)
        
        let destinationLocation = CLLocationCoordinate2DMake(50.388514, 30.490332)
        
        let sourceMark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)

        let destinationMark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
        
        let sourceMapItem = MKMapItem(placemark: sourceMark)
        
        let destinationMapItem = MKMapItem(placemark: destinationMark)
        
        let sourceAnatation = MKPointAnnotation()
        
        sourceAnatation.title = "Зеленая"
        
            if let location = sourceMark.location {
            
            sourceAnatation.coordinate = location.coordinate
            
            }
        let destinationAnnotation = MKPointAnnotation()
        destinationAnnotation.title = "Сеченова "
        
        if let location = destinationMark.location {
            destinationAnnotation.coordinate = location.coordinate
        }
        
         self.mapView.showAnnotations([sourceAnatation,destinationAnnotation], animated: true )
        
        
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .automobile
        
        
        let directions = MKDirections(request: directionRequest)
        
      
        directions.calculate {
            (response, error) -> Void in
            
            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                }
                
                return
            }
            
            let route = response.routes[0]
            self.mapView.add((route.polyline), level: MKOverlayLevel.aboveRoads)
            
            let rect = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
        }
        
        
        
        
        
    }

  
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.red
        renderer.lineWidth = 4.0
        
        return renderer
    }

}


//
//  ConfirmViewController.swift
//  OnTheMapV.1
//
//  Created by salma on 13/12/1441 AH.
//  Copyright © 1441 salma. All rights reserved.
//
import UIKit
import Foundation
import MapKit
class comfirmViewController: UIViewController, MKMapViewDelegate {
 
    @IBOutlet weak var MapView: MKMapView!
    
     var locale : StudentLocation?
    
    
    
    
    
    override func viewDidLoad() {

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Find Location", style: .done, target: self, action: #selector(self.Findlocation(_:)))
        MapView.delegate = self
        submitLocation()
    }
    
    
    
    
    
    @IBAction func Findlocation(_ sender: Any) {
        
        API.postLocation(link: locale?.mediaURL ?? "", latitude:locale?.latitude ?? 0 , longitude: locale?.longitude ?? 0, locationName: locale?.mapString ?? ""){
            (error) in guard error == nil else{
                self.myAlertMesseage(userMasseage: " Posting Location Filed :'(")
              return
               }
            self.dismiss(animated: true, completion: nil)
            
        }
   
        
    }
    
    
    
    
    
    
    func submitLocation() {
             
            let latitude = CLLocationDegrees(locale?.latitude ?? 0)
            let longitude = CLLocationDegrees(locale?.longitude ?? 0)
              let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
              let annotation = MKPointAnnotation()
              annotation.coordinate = coordinate
            annotation.title = locale?.mediaURL ?? ""
              MapView.addAnnotation(annotation)
           
        
            let region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            MapView.setRegion(region, animated: true)
  
          }
    
    
    
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
               
               let reuseId = "pin"
               
               var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView

               if pinView == nil {
                   pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                   pinView!.canShowCallout = true
                   pinView!.pinTintColor = .red
                   pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
               }
               else {
                   pinView!.annotation = annotation
               }
               
               return pinView
           }
    
}

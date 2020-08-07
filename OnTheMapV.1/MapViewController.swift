//
//  MapViewController.swift
//  OnTheMapV.1
//
//  Created by salma on 05/12/1441 AH.
//  Copyright © 1441 salma. All rights reserved.
//


import UIKit
import MapKit
class MapViewController: UIViewController, MKMapViewDelegate{
   
    @IBOutlet weak var MapView: MKMapView!
    
   
    var locationsData: LocationsData? {
        didSet {
            guard let locationsData = locationsData else { return }
            studentLocation = locationsData.results
        }
    }
     
     var studentLocation: [StudentLocation] = [] {
            didSet {
             DispatchQueue.main.async {
                  self.MapView.reloadInputViews()
           }
        }
    }
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MapView.delegate = self
        
              let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addLocation))
              let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(self.refresh(_:)))
              let logoutButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(self.logout(_:)))
              navigationItem.rightBarButtonItems = [addButton, refreshButton]
              navigationItem.leftBarButtonItem = logoutButton
    }
    

    
    override func viewWillAppear(_ animated: Bool) {
       updatePins()
        
    }

 
    
   func updatePins() {
       
        API.getAllLocations(){(data,error )in
            
            DispatchQueue.main.async {
                if error != nil {
                 let Messege = UIAlertController(
                    title: " Error  ", message: "Erorr loading", preferredStyle: .alert)
                    Messege.addAction(UIAlertAction(title: "OK", style: .default, handler: {
                        _ in return
                    }))
                    self.present(Messege,animated: true , completion: nil)
                  
                    
                }
               
                guard data != nil else {
                    
             let Messege = UIAlertController(
             title: " Error  ", message: "There was an error loading locations ", preferredStyle: .alert)
                 Messege.addAction(UIAlertAction(title: " OK", style: .default, handler: {
                       _ in return
                      }))
             self.present(Messege,animated: true , completion: nil)
                    return
    
                 }
                
                self.locationsData = data

       
        var annotations = [MKPointAnnotation]()
                guard let locationsArray = self.locationsData?.results else {
                      let locationsErrorAlert = UIAlertController(title: "Erorr loading locations", message: "There was an error loading locations", preferredStyle: .alert )
                      
                      locationsErrorAlert.addAction(UIAlertAction (title: "OK", style: .default, handler: { _ in
                          return
                      }))
                      self.present(locationsErrorAlert, animated: true, completion: nil)
                      return
                  }
       for location in locationsArray {
            
           guard let latitude = location.latitude, let longitude = location.longitude else { continue }
            let lat = CLLocationDegrees(latitude)
            let long = CLLocationDegrees(longitude)
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)

            let first = location.firstName
            let last = location.lastName
            let mediaURL = location.mediaURL

//             Here we create the annotation and set its coordiate, title, and subtitle properties
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(first ?? "") \(last ?? "")"
            annotation.subtitle = mediaURL
            
//            Finally we place the annotation in an array of annotations.
            annotations.append(annotation)
        }
        
//        When the array is complete, we add the annotations to the map.
                self.MapView.removeAnnotations(self.MapView.annotations)
                self.MapView.addAnnotations(annotations)
            }
            
        }
        
    }
    
    @objc private func logout(_ sender: Any) {
        
      let alertController = UIAlertController(title: "Alert", message: "Are you sure you want to logout?", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: {(_)in
            API.logout(){(err) in
                guard err == nil else{
                    return
                }
                 DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
                  }
            }
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController,animated: true , completion: nil)
    }
    
    @objc private func addLocation(_ sender: Any) {
        let navController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainAddLocation") as! UINavigationController
        present(navController, animated: true, completion: nil)
    }
    @objc private func refresh(_ sender: Any) {
        loadStudentLocations()
    }
    
    
    func loadStudentLocations() {
        let ai = self.startAnActivityIndicator()
          API.getAllLocations() {( data, error) in
          guard let data = data else {
           self.myAlertMesseage(userMasseage: " No internet connection")

               return
               }
             DispatchQueue.main.async { ai.stopAnimating() }
              guard data.results.count > 0 else {
               
               self.myAlertMesseage(userMasseage: "No pins Found !")
               return
            }
           self.locationsData = data
         }
     }
    
    //    MARK: - MKMapViewDelegate
        
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
        
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
               if control == view.rightCalloutAccessoryView {
                          let app = UIApplication.shared
                          if let toOpen = view.annotation?.subtitle!,
                              let url = URL(string: toOpen), app.canOpenURL(url) {
                              app.open(url, options: [:], completionHandler: nil)
                   }
               }
  
    }
    

    
    
}


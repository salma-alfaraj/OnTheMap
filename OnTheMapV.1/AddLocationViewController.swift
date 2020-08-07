//
//  AddLocationViewController.swift
//  OnTheMapV.1
//
//  Created by salma on 12/12/1441 AH.
//  Copyright © 1441 salma. All rights reserved.
//
import UIKit
import MapKit
import CoreLocation

class AddLocationViewController: UIViewController , UITextFieldDelegate{
    
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var linkeTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationTextField.delegate = self
        linkeTextField.delegate = self
        
         navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(self.exitClike(_:)))
        
    }
    
    @IBAction func FindLocation(_ sender: Any){
        
        
        let location = locationTextField.text
        let linke = linkeTextField.text
        
        if (location!.isEmpty) || (linke!.isEmpty){
            
            let alertmessege = UIAlertController(title: "Invalid",message: "All field are required",
                       preferredStyle: .alert )
                       alertmessege.addAction(UIAlertAction ( title: "OK",style: .default){(action) in return})
                self.present(alertmessege, animated: true, completion: nil)
                return
        }else{
            
            if UIApplication.shared.canOpenURL(URL(string: linke!)!) {
            
            let location = StudentLocation.init(
                createdAt : "",
                firstName: nil,
                lastName:nil,
                latitude : 0 ,
                longitude: 0,
                mapString : location,
                mediaURL : linke,
                objectId: "",
                uniqueKey: "",
                updatedAt: "" )
             self.AddLocation(location)
            
        }
        
        else {
            let alertMessege = UIAlertController(title: "Alert", message: "invalid URL!", preferredStyle: .alert)
            let okPress = UIAlertAction(title: "Ok", style: .default)
            alertMessege.addAction(okPress)
            self.present(alertMessege, animated: true, completion: nil)
        }
        }
        
      
    }
        
        
        
        func AddLocation(_ locus: StudentLocation) {
        let ai = self.startAnActivityIndicator()
        CLGeocoder().geocodeAddressString(locus.mapString!) {(placeMarks, err) in
         ai.stopAnimating()
          guard let firstLocation = placeMarks else { return }
            
            

            var locale = locus
            locale.latitude = firstLocation.first!.location?.coordinate.latitude
            locale.longitude = firstLocation.first!.location?.coordinate.longitude
            self.performSegue(withIdentifier: "MapSegue", sender: locale)

                 }
             }

       
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MapSegue",
            let segue = segue.destination as? comfirmViewController {
            segue.locale = (sender as! StudentLocation)
       
}

    }
    
    @objc private func exitClike(_ sender: Any) {
           self.dismiss(animated: true, completion: nil)
       }




    
}
    
    
    
    
    
    
    
    
    
    
    
    
    
    
        



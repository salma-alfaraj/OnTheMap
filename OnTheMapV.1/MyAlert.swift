//
//  MyAlert.swift
//  OnTheMapV.1
//
//  Created by salma on 05/12/1441 AH.
//  Copyright © 1441 salma. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController{
    
    
    func myAlertMesseage(userMasseage: String)
    {
        let alertMesseage = UIAlertController(title: "Alert", message: userMasseage, preferredStyle: UIAlertController.Style.alert)
        
        let oKPres = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alertMesseage.addAction(oKPres)
        self.present(alertMesseage,animated: true,completion: nil)
    }
    
    
  
}

extension UIViewController {
func startAnActivityIndicator() -> UIActivityIndicatorView {
    let activityIndicator = UIActivityIndicatorView(style: .gray)
    self.view.addSubview(activityIndicator)
    self.view.bringSubviewToFront(activityIndicator)
    activityIndicator.center = self.view.center
    activityIndicator.hidesWhenStopped = true
    activityIndicator.startAnimating()
    return activityIndicator
}
}

//
//  TableCell.swift
//  OnTheMapV.1
//
//  Created by salma on 07/12/1441 AH.
//  Copyright © 1441 salma. All rights reserved.
//
import UIKit
import Foundation
class tableCell: UITableViewCell{
    
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var linklLabel: UILabel!
    
    
    var locationInfo : StudentLocation? {
           didSet{
              guard let locationInfo = locationInfo else{return}
               locationLabel.text = "\(locationInfo.firstName ?? "") \(locationInfo.lastName ?? "")"
               linklLabel.text = locationInfo.mediaURL
           }
           
       }
}

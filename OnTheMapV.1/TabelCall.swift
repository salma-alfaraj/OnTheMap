//
//  TabelCall.swift
//  OnTheMapV.1
//
//  Created by salma on 07/12/1441 AH.
//  Copyright © 1441 salma. All rights reserved.
//

//import Foundation
import UIKit


class TableCell: UITableViewCell {

    @IBOutlet weak var Location: UILabel!

    @IBOutlet weak var Link: UILabel!

    var locationInfo : StudentLocation? {

        didSet{
                 guard let locationInfo = locationInfo else{return}
    Location.text = "\(locationInfo.firstName ?? "") \(locationInfo.lastName ?? "")"
    Link.text = locationInfo.mediaURL
              }

    }
  

}

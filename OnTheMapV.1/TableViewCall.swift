//
//  TableViewCall.swift
//  OnTheMapV.1
//
//  Created by salma on 07/12/1441 AH.
//  Copyright © 1441 salma. All rights reserved.
//


import UIKit
class tableCall: UITableViewCell{
    
    
    @IBOutlet  var locationLabel: UILabel!
    @IBOutlet  var linkLabel: UILabel!
    

    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    
    var locationInfo : StudentLocation? {
    didSet{
       guard let locationInfo = locationInfo else{return}
        locationLabel.text = "\(locationInfo.firstName ?? "") \(locationInfo.lastName ?? "")"
        linkLabel.text = locationInfo.mediaURL
    }
}
}

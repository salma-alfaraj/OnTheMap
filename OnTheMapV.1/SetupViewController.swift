//
//  SetupViewController.swift
//  OnTheMapV.1
//
//  Created by salma on 13/12/1441 AH.
//  Copyright © 1441 salma. All rights reserved.
//


import UIKit
import Foundation


//class setupviewCotroller: UIViewController{
//
//
//    var locationsData: LocationsData?
//    override func viewDidLoad() {
//        setup()
//        loadStudentLocations()
//    }
//
//
//
//    func setup() {
//           let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addLocation(_:)))
//           let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(self.refreshClick(_:)))
//           let logout = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(self.logoutClick))
//
//           navigationItem.rightBarButtonItems = [add, refresh]
//           navigationItem.leftBarButtonItem = logout
//       }
//
//    @objc private func logoutClick(_ sender: Any) {
//
//        let alertController = UIAlertController(title: "Alert", message: "Are you sure you want to logout?", preferredStyle: .alert)
//        alertController.addAction(UIAlertAction(title: "Logout", style: .destructive, handler: {(_)in
//            API.logout(){(err) in
//                guard err == nil else{
//                    return
//                }
//                 DispatchQueue.main.async {
//                self.dismiss(animated: true, completion: nil)
//                  }
//            }
//        }))
//        alertController.addAction(UIAlertAction(title: "Cansel", style: .cancel, handler: nil))
//        present(alertController,animated: true , completion: nil)
//
//       }
//
//    @objc private func addLocation(_ sender: Any) {
//           let navController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddLocationNavigationController") as! UINavigationController
//
//           present(navController, animated: true, completion: nil)
//       }
//
//
//    @objc private func refreshClick(_ sender: Any) {
//           loadStudentLocations()
//       }
//
//
//
//  func loadStudentLocations() {
//     let ai = self.startAnActivityIndicator()
//       API.getAllLocations() {( data, error) in
//       guard let data = data else {
//        self.myAlertMesseage(userMasseage: " No internet connection")
//
//            return
//            }
//          DispatchQueue.main.async { ai.stopAnimating() }
//           guard data.results.count > 0 else {
//
//            self.myAlertMesseage(userMasseage: "No pins Found !")
//            return
//         }
//        self.locationsData = data
//      }
//  }
//}

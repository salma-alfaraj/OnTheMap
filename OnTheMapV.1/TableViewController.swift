//
//  TableViewController.swift
//  OnTheMapV.1
//
//  Created by salma on 05/12/1441 AH.
//  Copyright © 1441 salma. All rights reserved.
//
import Foundation
import UIKit
class TableViewController: UITableViewController{
    
    
    
    var locationsData: LocationsData? {
        didSet {
            guard let locationsData = locationsData else { return }
            studentsite = locationsData.results
        }
    }
     
     var studentsite: [StudentLocation] = [] {
            didSet {
             DispatchQueue.main.async {
                 self.tableView.reloadData()
             }
           }
        }
    
    


     
    override func viewDidLoad() {
        super.viewDidLoad()
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addLocation))
                     let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(self.refresh(_:)))
                     let logoutButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(self.logout(_:)))
                     navigationItem.rightBarButtonItems = [addButton, refreshButton]
                     navigationItem.leftBarButtonItem = logoutButton
        loadLocations()
       
        
    }
    override func viewWillAppear(_ animated: Bool) {
   
        super.viewDidAppear(animated)

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

    
    
    
    
    
    func loadLocations() {
        
        let ai = self.startAnActivityIndicator()
        API.getAllLocations(){(data ,error) in
            guard let data = data else{

             let alertMessege = UIAlertController(title: "alert", message: error?.localizedDescription ,preferredStyle: .alert)
                alertMessege.addAction(UIAlertAction(title:"OK",style:.default,handler:nil))

                return
            }
            DispatchQueue.main.async { ai.stopAnimating() }
              guard data.results.count > 0 else{
                let alertMessege = UIAlertController(title: "alert", message: error?.localizedDescription ,preferredStyle: .alert)
                alertMessege.addAction(UIAlertAction(title:"OK",style:.default,handler:nil))

                           return
                        }
                       self.locationsData = data

            }
         

        }
      
   

   
//    MARK: Tabel View Source.
    
    
  override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return studentsite.count
            
        }
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableCell
            
            cell.locationInfo = studentsite[indexPath.row]
            
            return cell
        }
        
        
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            
        let location = self.studentsite[indexPath.row]
            let mediaURL = location.mediaURL!
            
            guard let url = URL(string: mediaURL), UIApplication.shared.canOpenURL(url) else {
                 
              let alert = UIAlertController(title: "Erorr",message: "invalid URL ",preferredStyle: .alert )
                 alert.addAction(UIAlertAction (title: "OK", style: .default, handler: { _ in
                     return }))
                 self.present(alert, animated: true, completion: nil)
                 return
             }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            
        }
  

    
}
    
    


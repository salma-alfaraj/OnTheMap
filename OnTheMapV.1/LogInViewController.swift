//
//  LogInViewController.swift
//  OnTheMapV.1
//
//  Created by salma on 05/12/1441 AH.
//  Copyright © 1441 salma. All rights reserved.
//

import Foundation
import UIKit
class LogInViewController: UIViewController{
    
    
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    
    
    
    @IBAction func logInClick(_ sender: Any){
        
        
        let email = emailTextField.text
        let password = passwordTextField.text


        if (email!.isEmpty) || (password!.isEmpty) {

        let myAlertMassege = UIAlertController (title: "Alert", message: "All fields are requset!", preferredStyle: .alert)

        myAlertMassege.addAction(UIAlertAction (title: "OK", style: .default, handler: { _ in
            return
        }))

        self.present (myAlertMassege, animated: true, completion: nil)
        }else{


            API.loginStudent(email, password, completion: {(loginSuccess , key , error)in

                DispatchQueue.main.async {

                    if error != nil {
                        let myAlertMassege = UIAlertController(title: "Alert", message: "There was an error performing your request", preferredStyle: .alert )

                        myAlertMassege.addAction(UIAlertAction (title: "OK", style: .default, handler: { _ in
                            return
                        }))
                        self.present(myAlertMassege, animated: true, completion: nil)
                        return
                    }

                    if !loginSuccess {
                        let loginAlert = UIAlertController(title: "Alert", message: "Login Failed", preferredStyle: .alert )

                        loginAlert.addAction(UIAlertAction (title: "OK", style: .default, handler: { _ in
                            return
                        }))
                        self.present(loginAlert, animated: true, completion: nil)
                    } else {
                        self.performSegue(withIdentifier: "MapViewController", sender: nil)

                }
                }})


        }
    
    
    }
    
    
    @IBAction func signInClick(_ sender: Any) {
          
    
      UIApplication.shared.open(URL(string: "https://www.udacity.com/account/auth#!/signup")!)
       }
    
    
    
    
    
    
    
    
    
}

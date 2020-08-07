//
//  UserInfo.swift
//  OnTheMapV.1
//
//  Created by salma on 13/12/1441 AH.
//  Copyright © 1441 salma. All rights reserved.
//
import UIKit
import Foundation

struct UserInfo {
    var key: String?
    var firstName: String?
    var lastName: String?
}

struct AccountSession: Codable {
    let account: Account?
    let session: Session?
}
struct Session : Codable {
    let id: String
    let expiration: String
}
struct Account:Codable {
    let registered: Bool
    let key: String
}

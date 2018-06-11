//
//  UserData.swift
//  MyFirstSwiftApp
//
//  Created by Prajakta Shinde on 4/25/18.
//  Copyright © 2018 Prajakta Shinde. All rights reserved.
//

import Foundation
import UIKit

class UserData {
    
    //MARK: Properties
    let id: Int
    let nameData: String?
    let emailData: String?
    let unameData: String?
    let pwdData: String?
    
    init(id: Int, name:String, email: String, username: String, password: String)
     {
        self.id = id
        self.nameData = name
        self.emailData = email
        self.unameData = username
        self.pwdData = password
     }
    
}

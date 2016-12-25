//
//  User.swift
//  Paladar
//
//  Created by zhengf on 10/16/16.
//  Copyright © 2016 SasaCorp. All rights reserved.
//

import Foundation
import Firebase
struct UserFZ{
    let uid: String
    let email:String
    
    init(userData:FIRUser){
        uid = userData.uid
        if let mail = userData.providerData.first?.email{
            email = mail
        }
        else{
            email = ""
        }
    }
    
    init(uid:String, email:String){
        self.uid = uid
        self.email = email
    }
    
}

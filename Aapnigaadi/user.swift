//
//  user.swift
//  Aapnigaadi
//
//  Created by sreerag p on 10/07/19.
//  Copyright © 2019 sreerag p. All rights reserved.
//

import Foundation
class user{
    public let phone:String
    public let status:NSNumber
    public let id:NSNumber
    public let created_at:String
    public let email:String
    public let updated_at:String
    public let name:String
    public let email_verified_at:String
    public init(dic:[String:Any]){
        phone = dic["phone"] as! String
        status = dic["status"] as! NSNumber
        id = dic["id"] as! NSNumber
        created_at = dic["created_at"] as! String
        email = dic["email"] as! String
        updated_at = dic["updated_at"] as! String
        name = dic["name"] as! String
        if let dc:String = dic["email_verified_at"] as? String{
            email_verified_at = dc
        }else{
            email_verified_at = ""
        }
    }
}

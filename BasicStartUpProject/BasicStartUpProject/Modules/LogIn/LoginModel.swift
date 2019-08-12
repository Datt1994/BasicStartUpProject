//
//  LoginModel.swift
//
//  Created by datt on 13/05/19.
//  Copyright © 2019 datt. All rights reserved.
//  Create Model Form JSON response :- http://www.json4swift.com/

import Foundation

struct LoginModel : Codable {
    let status : String?
    var data : LoginData?
    let message : String?
    
    enum CodingKeys: String, CodingKey {
        
        case status = "status"
        case data = "data"
        case message = "message"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        data = try values.decodeIfPresent(LoginData.self, forKey: .data)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }
    
}
struct LoginData : Codable {
    var id : Int?
    var first_name : String?
    var last_name : String?
    var email_id : String?
    var status : Bool?
    var token : String?

    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case first_name = "first_name"
        case last_name = "last_name"
        case email_id = "email_id"
        case status = "status"
        case token = "token"

    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
        email_id = try values.decodeIfPresent(String.self, forKey: .email_id)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        token = try values.decodeIfPresent(String.self, forKey: .token)
    }
}

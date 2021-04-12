//
//  User.swift
//  MyCryptoPortfolio
//
//  Created by Connor Boothe on 4/7/21.
//

import Foundation
struct Coins: Codable {
    var name: String
    var amount: Double
}

struct User: Decodable {
    var first_name: String
    var last_name: String
    var email: String
    var password: String
    var coins:Array<Coins>
    
}


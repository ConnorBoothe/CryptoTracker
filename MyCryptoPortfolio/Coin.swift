//
//  Coin.swift
//  MyCryptoPortfolio
//
//  Created by Connor Boothe on 12/25/20.
//

import Foundation

struct Coin: Decodable {
    var name: String
    var image: String
    var price: Double
    var ticker: String
}


//
//  Header.swift
//  MyCryptoPortfolio
//
//  Created by Connor Boothe on 3/25/21.
//

import SwiftUI

struct Header: View {
    var value:Double
    var body: some View {
        VStack (alignment: .leading){
                Text("Cryptfolio")
                Text(String(value))
            
        }.frame(width: 200).padding(5)

    }
}


//
//  Header.swift
//  MyCryptoPortfolio
//
//  Created by Connor Boothe on 3/25/21.
//

import SwiftUI

struct Header: View {
    var body: some View {
        VStack (alignment: .leading){
           
                Text("Cryptfolio")
//                Text("Connor") .font(.system(size: 14))
            
            
        }.frame(width: 200).padding(5)

    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header()
    }
}

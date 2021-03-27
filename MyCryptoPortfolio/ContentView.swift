//
//  ContentView.swift
//  MyCryptoPortfolio
//
//  Created by Connor Boothe on 12/25/20.
//

import SwiftUI
import NavigationKit

struct ContentView: View {
    
    //controls the ui
    var body: some View {
        VStack {
         Header()
          AddCoinButton()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}

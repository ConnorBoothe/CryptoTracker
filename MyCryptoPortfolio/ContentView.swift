//
//  ContentView.swift
//  MyCryptoPortfolio
//
//  Created by Connor Boothe on 12/25/20.
//

import SwiftUI
import NavigationKit

struct ContentView: View {
    @State public var portfolio_value = 0.00;
    @State public var assets_available:Array<Coin> = [];
    //controls the ui
    var body: some View {
        VStack {
            Text("Trying")
            AddCoinButton(coins: self.assets_available)

            var _: () = API().getMarketData() { coinArray in ()
                print(coinArray)
//                self.assets_available = coinArray;
            }
           
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

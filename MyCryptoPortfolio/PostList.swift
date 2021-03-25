//
//  PostList.swift
//  MyCryptoPortfolio
//
//  Created by Connor Boothe on 12/25/20.
//

import SwiftUI

struct PostList: View {
    @State private var BTCAmount = 0.8
    @State private var BTCPrice = 0.00;
    @State private var ETHAmount = 5.5
    @State  private var bitcoin = Coin(name: "Bitcoin", image: "", price: 0.00, ticker: "BTC");
    
    var body: some View {
        var _: () = API().getBitcoin { coin in (Double)()
            self.bitcoin = coin;
        };
     
            VStack (alignment: .leading){
                HStack{
//                    AsyncImage(
//                               url: self.bitcoin.image,
//                               placeholder: Text("Loading ...")
//                           ).aspectRatio(contentMode: .fit)
                    VStack {
                        Text(String(self.bitcoin.name))
                            .font(.system(size: 17))
                        Text(String(self.bitcoin.ticker)).font(.system(size: 13))
                            .foregroundColor(Color.gray)
                    }
                    Spacer()
                    VStack {
                        Text("$"+String(self.bitcoin.price * self.BTCAmount))
                        .font(.system(size: 15))
                         Text(String(self.BTCAmount)).foregroundColor(Color.gray)
                            .font(.system(size: 13))
                    }
                }
                .padding(40)
            }
            Spacer()
        }
       
    
}



//
//  PostList.swift
//  MyCryptoPortfolio
//
//  Created by Connor Boothe on 12/25/20.
//

import SwiftUI
import URLImage
struct PostList: View {
    @State private var BTCAmount = 0.8
    @State private var BTCPrice = 0.00;
    @State private var ETHAmount = 5.5
    @State public var image:URL = URL(string: "http://google.com")!
    @State  private var bitcoin = Coin(name: "Bitcoin", image: "", price: 0.00, ticker: "BTC");
    
    var body: some View {
        
        var _: () = API().getBitcoin { coin in (Double)()
            self.bitcoin = coin;
            self.image = URL(string: self.bitcoin.image)!;
            
        };
        
//        let imgURL = URL(string: )!
      
//        URLImage(url:imgURL) { image in
//
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//        }
            VStack (alignment: .leading){
                HStack{
                    
                    URLImage(url: self.image) { image in
                        image
                            .resizable()
                            .frame(width: 50, height: 50)
                            .aspectRatio(1, contentMode: .fit)
                            
                    }
                    VStack(alignment: .leading) {
                        Text(String(self.bitcoin.name))
                            .font(.system(size: 16))
                        Text(String(self.bitcoin.ticker)).font(.system(size: 13))
                            .foregroundColor(Color.gray)
                    }
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("$"+String(round((self.bitcoin.price * self.BTCAmount)*100)/100))
                        .font(.system(size: 15))
                         Text(String(self.BTCAmount)).foregroundColor(Color.gray)
                            .font(.system(size: 13))
                    }
                }
                .padding(20)
                .padding(.trailing, 30)
            }
            Spacer()
        }
       
    
}



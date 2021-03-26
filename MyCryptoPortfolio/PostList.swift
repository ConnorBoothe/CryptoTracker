//
//  PostList.swift
//  MyCryptoPortfolio
//
//  Created by Connor Boothe on 12/25/20.
//

import SwiftUI
import URLImage
struct PostList: View {
    @State private var assets:KeyValuePairs = ["bitcoin": 0.8,
                                              "ethereum": 5.5]
    @State private var assetsArray:Array<Coin> = [Coin(name: "Bitcoin", image: "", price: 0.00, ticker: "BTC", amount:0.0)];
    @State private var BTCAmount = 0.8
    @State private var ETHAmount = 5.5
    @State public var image:URL = URL(string: "http://google.com")!
    @State  private var bitcoin = Coin(name: "Bitcoin", image: "", price: 0.00, ticker: "BTC", amount:0.0);
    
    var body: some View {
//        for coin in self.assetsArray {
//            print(coin)
//        }
            VStack {
                Text(String(self.assetsArray.count));
                
//                List {
//                    
//                }
                Text("$"+String(round((self.bitcoin.price * self.BTCAmount)*100)/100))
                    .font(.system(size: 30))
                Text("Portfolio value")
                    .font(.system(size: 13))
                    .foregroundColor(Color.gray)
               
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
                        Text("$"+String(self.bitcoin.price))
                        .font(.system(size: 15))
                         Text(String(self.BTCAmount)).foregroundColor(Color.gray)
                            .font(.system(size: 13))
                    }
                   
                }
                .padding(20)
                .padding(.trailing, 30)
            }
            Spacer()
        Button(action: {
            // What to perform
            print("button clicked")
          
            var _: () = API().getBitcoin(assets: self.assets) { coinArray in ()
               
                self.assetsArray = coinArray;
                print("coins")
                for (coin) in self.assetsArray {
//                    print(coin)
                    Text(coin.name)
                }
//                self.image = URL(string: self.bitcoin.image)!;
                
            };
        }) {
            // How the button looks like
            Text("Refresh Prices")
                .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                .cornerRadius(40)
                .font(.system(size: 16))
        }
        }
       
    
}



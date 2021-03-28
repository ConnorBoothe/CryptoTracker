//
//  PostList.swift
//  MyCryptoPortfolio
//
//  Created by Connor Boothe on 12/25/20.
//

import SwiftUI
import URLImage
import NavigationKit
struct PostList: View {
    @State private var assets:KeyValuePairs = ["bitcoin": 0.8,
                                               "ethereum": 5.5,"cardano":20]
    @State private var assetsArray:Array<Coin> = [Coin(name: "Bitcoin", image: URL(string:"https://google.com")!, price: 0.00, ticker: "BTC", amount:0.0)];
    @State public var image:URL = URL(string: "https://google.com")!
    @State public var portfolio_value = 0.00;
    var coins:Array<Coin>;
    var body: some View {
//        for coin in self.assetsArray {
//            print(coin)
//        }
        
            VStack {
                Text("$"+String(round((self.portfolio_value))))
                    .font(.system(size: 30)).padding(0)
                Spacer()
                Text("Portfolio value")
                    .font(.system(size: 13))
                    .foregroundColor(Color.gray)
                Spacer()
                List {
                    ForEach (0..<self.assetsArray.count, id: \.self)  {i in
                        HStack{
                            URLImage(url: self.assetsArray[i].image) { image in
                                image
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .aspectRatio(1, contentMode: .fit)
                                    
                            }
                            VStack(alignment: .leading) {
                                Text(String(self.assetsArray[i].name))
                                    .font(.system(size: 16))
                                Text(String(self.assetsArray[i].ticker)).font(.system(size: 13))
                                    .foregroundColor(Color.gray)
                            }
                            VStack(alignment: .leading) {
                                Text("$"+String(self.assetsArray[i].price))
                                .font(.system(size: 15))
                                Text(String(self.assetsArray[i].amount)).foregroundColor(Color.gray)
                                    .font(.system(size: 13))
                            }
                           
                        }
                        .padding(20)
                        .padding(.trailing, 30)
                    }
                    NavigationLink(destination: AddCoin()){
                        Text("Add Asset")
                    }.buttonStyle(PlainButtonStyle())

                  
                }.onAppear{
                    var _: () = API().getAssets(assets: self.assets) { coinArray in ()
                        self.portfolio_value = 0;
                        self.assetsArray = coinArray;
                        for (coin) in self.assetsArray {
                            self.portfolio_value += (coin.price * coin.amount)
                        }
        //                self.image = URL(string: self.assetsArray[0].image)!;
                        
                    };
                }
                Spacer()
                Button(action: {
                    // What to perform
                    var _: () = API().getAssets(assets: self.assets) { coinArray in ()
                        self.portfolio_value = 0;
                        self.assetsArray = coinArray;
                        for (coin) in self.assetsArray {
                            self.portfolio_value += (coin.price * coin.amount)
                        }
        //                self.image = URL(string: self.assetsArray[0].image)!;
                        
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
       
    
}



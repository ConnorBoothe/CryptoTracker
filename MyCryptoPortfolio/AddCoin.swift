//
//  AddCoin.swift
//  MyCryptoPortfolio
//
//  Created by Connor Boothe on 3/26/21.
//

import SwiftUI
import URLImage
struct AddCoinButton: View {
    var coins:Array<Coin>;
    var body: some View {
        
        NavigationView {
            
            PostList(coins: coins);
                Spacer()
                
//            .navigationBarTitle("Add Coin", displayMode: .automatic)
        }
    }
}

struct AddCoin: View {
    @State private var name: String = "";
    @State private var coinName: String = "";
    @State private var amount: String = "";
    @State private var floatAmount: Float = 0.00;
    @State private var assetsArray: Array<Coin> = [];

    var body: some View {
        Text("Select Asset")
            .font(.title)
        Spacer()
        VStack{
            List{
                
           
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
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("$"+String(self.assetsArray[i].price))
                        .font(.system(size: 15))
                        
                    }
                   
                }
                .padding(20)
                .padding(.trailing, 30)
            }
            }.onAppear{
                var _: () = API().getMarketData() { coins in ()
                    self.assetsArray = coins;
                    
                };
            }
           
Spacer()
            
            
        }
       

        }
       
}


//
//  AddCoin.swift
//  MyCryptoPortfolio
//
//  Created by Connor Boothe on 3/26/21.
//

import SwiftUI
import URLImage

struct AddCoin: View {
    @Binding public var portfolio_value: Double;
    @Binding public var user: User
    @Binding public var coins_supported:Array<String>
    @Binding public var coins_available: Array<Coin>
    @Binding public var assetsArray: Array<Coin>
    var body: some View {
        Text("Select Asset")
            .font(.title)
        Spacer()
        VStack{
            List{
                
            ForEach (0..<self.coins_available.count, id: \.self)  {i in
                NavigationLink(destination: SingleCoinView(coin: self.$coins_available[i],
                                                           portfolio_value: self.$portfolio_value,
                                                           user: self.$user, assetsArray: self.$assetsArray)
                    ){
                    HStack{

                        URLImage(url: self.coins_available[i].image) { image in
                            image
                                .resizable()
                                .frame(width: 50, height: 50)
                                .aspectRatio(1, contentMode: .fit)

                        }
                        VStack(alignment: .leading) {
                            Text(String(self.coins_available[i].name))
                                .font(.system(size: 16))
                            Text(String(self.coins_available[i].ticker)).font(.system(size: 13))
                                .foregroundColor(Color.gray)
                        }
                        Spacer()
                        VStack(alignment: .leading) {
                            Text("$"+API().formatPrice(price:String(self.coins_available[i].price)))
                                .font(.system(size: 13))
                                .foregroundColor(Color.gray)

                        }

                    }
                    .padding(20)
                    .padding(.trailing, 30)
                   }
                }
            }.onAppear{
                print(self.coins_supported)
                var _: () = API().getMarketData(assets:self.coins_supported) { coins in ()
                    self.coins_available = coins;
                    print(self.coins_available[3])
                };
            }
           
Spacer()
            
     }
       

        }
       
}


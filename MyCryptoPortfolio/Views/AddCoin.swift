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
    @Binding public var assetsArray:Array<Coin>
    @Binding public var assets:KeyValuePairs<String, Double>

    var body: some View {
        Text("Select Asset")
            .font(.title)
        Spacer()
        VStack{
            List{
                
            ForEach (0..<self.assetsArray.count, id: \.self)  {i in
                NavigationLink(destination: SingleCoinView(coin: self.$assetsArray[i],
                                                           assets: self.$assets, portfolio_value: self.$portfolio_value)
                    ){
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
                            Text("$"+API().formatPrice(price:String(self.assetsArray[i].price)))
                                .font(.system(size: 13))
                                .foregroundColor(Color.gray)

                        }

                    }
                    .padding(20)
                    .padding(.trailing, 30)
                   }
                }
            }.onAppear{
                var _: () = API().getMarketData(assets:self.assets) { coins in ()
                    self.assetsArray = coins;
                };
            }
           
Spacer()
            
     }
       

        }
       
}


//
//  SingleCoinView.swift
//  MyCryptoPortfolio
//
//  Created by Connor Boothe on 3/28/21.
//

import SwiftUI
import URLImage

struct SingleCoinView: View {
    @Binding public var coin:Coin;
    @Binding public var portfolio_value: Double;
    @Binding public var user: User;
    @Binding public var assetsArray: Array<Coin>
    var body: some View {
        Spacer()
        VStack {
            URLImage(url: self.coin.image) { image in
                image
                    .resizable()
                    .frame(width: 100, height: 100)
                    .aspectRatio(1, contentMode: .fit)

            }
            Text(self.coin.name.capitalized)
                .font(.system(size: 23))
                .padding(10)
            Text(API().formatPrice(price:String(self.coin.price)))
                .font(.system(size: 30))
          

                HStack {
                    NavigationLink(destination: PurchaseCoin(coin: self.$coin, portfolio_value: self.$portfolio_value, user: self.$user)){
                    Text("Buy")
                        .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                        .cornerRadius(20)
                        .font(.system(size: 16))
                    }
                    NavigationLink(destination: SellCoin(coin: self.$coin, portfolio_value: self.$portfolio_value, user: self.$user, assetsArray: self.$assetsArray)){
                    Text("Sell")
                        .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                        .cornerRadius(20)
                        .font(.system(size: 16))
                        
                    }
               

            }
            Text("Description")
                .font(.system(size: 20))
                .onTapGesture {
//                    if (self.showDesc == true) {
//                        self.showDesc = false;
//                    }
//                    else {
//                        self.showDesc = true;
//                    }
                }
//            if (self.showDesc == true) {
            ScrollView{
                Text(self.coin.desc)
                    .font(.body)
                    .padding(20)

//            }
            }

            Spacer()
      }
        
    }

}

//
//  PurchaseCoin.swift
//  MyCryptoPortfolio
//
//  Created by Connor Boothe on 3/28/21.
//

import SwiftUI
import CurrencyFormatter
import URLImage
struct PurchaseCoin: View {
    @Binding public var coin:Coin;
    @Binding public var portfolio_value:Double;
    @State private var FiatAmount: String = "";
//    @ObservedObject var input = NumberOnly()
    @State private var CoinAmount: Double = 0.00000000
//   @State public var portfolio_value:Double;

    var body: some View {
//        Text(String(portfolio_value))
        Text("Purchase \(coin.name)")
            .font(.title)
        Text(" \(coin.amount)")
            .font(.title)
        HStack {
            Image(systemName: "dollarsign.circle.fill")
                .font(.system(size: 40))
                .foregroundColor(Color.gray)
            let formatter = CurrencyFormatter {
                $0.currency = .dollar
                  $0.locale = CurrencyLocale.englishUnitedStates
            }
            let formattedString = formatter.string(from:30.00) //€30.00
            TextField("0.00", text: $FiatAmount)
                .keyboardType(.decimalPad)
                .font(.system(size: 40))
                .frame(width: 200)
                .foregroundColor(Color.gray)

        }
        .padding(50)
        .onChange(of: FiatAmount) { newValue in
                        print("Changed fiat amount")
            
            print( Double(FiatAmount) ?? 0)
            if(self.FiatAmount != ""){
                self.CoinAmount = Double(self.FiatAmount)! * (1/coin.price);
            }
            else {
                self.CoinAmount = 0.00000000;
            }
           
           
            }
   
        HStack {
            URLImage(url: coin.image) { image in
                image
                    .resizable()
                    .frame(width: 40, height: 40)
                    .aspectRatio(1, contentMode: .fit)
                    
            }
            Text(String(self.CoinAmount))
                .foregroundColor(Color.black)
                .font(.system(size: 23))
           


        }.padding(50)
      
        Button(action: {
            // purchase logic goes here
//            print(self.FiatAmount)
          //    self.portfolio_value += Double(self.FiatAmount)!;
              self.coin.amount += Double(self.CoinAmount);
//            print(self.portfolio_value)
           
        }) {
            // How the button looks like
            Text("Confirm Purchase")
                .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                .cornerRadius(40)
                .font(.system(size: 16))
        }
        Spacer()
    }
}


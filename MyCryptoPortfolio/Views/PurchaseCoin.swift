//
//  PurchaseCoin.swift
//  MyCryptoPortfolio
//
//  Created by Connor Boothe on 3/28/21.
//

import SwiftUI
import URLImage
struct PurchaseCoin: View {
    @Binding public var coin: Coin;
    @Binding public var portfolio_value: Double;
    @Binding public var user: User;
    @State private var FiatAmount: String = "0.00";
//    @ObservedObject var input = NumberOnly()
    @State private var CoinAmount: Double = 0.00000000
    @State private var PurchaseComplete:Bool = false
    @State public var type:String = "Buy";
//   @State public var portfolio_value:Double;

    var body: some View {
        ZStack{
            
    
        VStack{
            VStack{
                Text("\(coin.amount)")
                    .font(.system(size: 20))
                Text("\(coin.ticker) balance")
                    .foregroundColor(Color.gray)
                        .font(.system(size: 15))
            }
            .padding(20)
           
           
            VStack{
                HStack {
                    Text("$")
                    TextField("0.00", text: $FiatAmount)
                        .disabled(true)
                        .fixedSize()
                        

                }
               
                .padding(1)
                .multilineTextAlignment(.leading)
        .frame(maxWidth: .infinity)
        .font(.system(size: 40))
        .foregroundColor(Color.blue)
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
                Text("Max $100,000")
                    .font(.system(size: 14))
                PricePad(FiatAmount: self.$FiatAmount)
                
                
                Button(action: {
                    if(Double(self.FiatAmount)! >= 10) {
                       
                        API().addCoin(name: self.coin.name, amount: String(self.CoinAmount), email: self.user.email){ coins in ()
                                self.user.coins = coins;
                                self.PurchaseComplete = true;
//                                self.FiatAmount = "0";
                                self.coin.amount += Double(self.CoinAmount);
                                print("Coin added")
                            }
                    }
                }) {
                    // How the button looks like
                    Text("Purchase \(coin.ticker)")
                        .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                        .cornerRadius(40)
                        .font(.system(size: 16))
                }
                .sheet(isPresented: $PurchaseComplete, onDismiss: {
                            print(self.PurchaseComplete)
                        }) {
                    Receipt(coin: self.$coin, CoinAmount: self.$CoinAmount, FiatAmount: self.$FiatAmount, type: self.$type)
                        }
            if(Double(self.FiatAmount)! >= 10) {
                HStack {
                    URLImage(url: coin.image) { image in
                        image
                            .resizable()
                            .frame(width: 40, height: 40)
                            .aspectRatio(1, contentMode: .fit)
                            
                    }
                    Text(String(Double(round(100000000*self.CoinAmount))/100000000))
                        .foregroundColor(Color.black)
                        .font(.system(size: 23))
                   


                }.padding(20)
            }
            else {
                HStack {
                    Text("$10 minimum purchase")
                        .foregroundColor(Color.red)
                        .font(.system(size: 14))
                   


                }.padding(20)
            }
        }
        Spacer()
        }
    }
    }
}


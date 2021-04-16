//
//  SellCoin.swift
//  MyCryptoPortfolio
//
//  Created by Connor Boothe on 3/28/21.
//

import SwiftUI
import URLImage
struct SellCoin: View {
    @Binding public var coin: Coin;
    @Binding public var portfolio_value: Double;
    @Binding public var user: User;
    @Binding public var assetsArray: Array<Coin>;
    @State private var FiatAmount: String = "0.00";
    @State private var CoinAmount: Double = 0.00000000
    @State private var SaleComplete:Bool = false
    @State public var type:String = "Sell";

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
                
                Button(action: {
                    print(coin.amount)
                    print(Double(self.FiatAmount)!)
                    self.FiatAmount = String(Double(round(100*(coin.amount * coin.price)/100)))
                    
                        
                    }){
                        Text("Max")
                            .font(.system(size: 14))
                    }
               
                PricePad(FiatAmount: self.$FiatAmount)
                
                
                Button(action: {
                    if(Double(self.FiatAmount)! >= 10) {
                       
                        API().sellCoin(name: self.coin.name, amount: String(self.CoinAmount), email: self.user.email){ coins in ()
                                self.user.coins = coins;
                            
                                self.SaleComplete = true;
//                                self.FiatAmount = "0";
                                self.coin.amount -= Double(self.CoinAmount);
                                print("Coin sold")
//                            self.assetsArray = [];
                            }
                    }
                }) {
                    // How the button looks like
                    Text("Sell \(coin.ticker)")
                        .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                        .cornerRadius(40)
                        .font(.system(size: 16))
                }
                .sheet(isPresented: $SaleComplete, onDismiss: {
                            print(self.SaleComplete)
                        }) {
                    Receipt(coin: self.$coin, CoinAmount: self.$CoinAmount, FiatAmount: self.$FiatAmount,type: self.$type)
                        }
            if(Double(self.FiatAmount)! >= 10) {
                HStack {
                    URLImage(url: coin.image) { image in
                        image
                            .resizable()
                            .frame(width: 40, height: 40)
                            .aspectRatio(1, contentMode: .fit)
                            
                    }
                    Text(String(Double(round(100000000*self.CoinAmount)/100000000)))
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


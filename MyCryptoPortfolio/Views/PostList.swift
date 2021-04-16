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
    @State public var assetsArray:Array<Coin> = [];
    @Binding public var portfolio_value:Double;
    @Binding public var user:User;
    @Binding public var login:Bool;
    @Binding public var coins_supported:Array<String>;
    @Binding public var coins_available:Array<Coin>;

    @State public var value_string:String = "";
    var body: some View {
            VStack {
                HStack{
                    Text(String(self.user.first_name) + " " + String(self.user.last_name))
                        .font(.system(size: 15)).padding(20)
                    Button(action: {
                        // What to perform
                        self.login = false;
                        self.user = User(first_name: "", last_name:"", email: "",
                                         password: "", coins:[Coins(name:"",amount: 0.0)])
                    }) {
                           Text("Logout")
                    }.font(.system(size: 15))
                    .frame(width: 60, height: 20)
                    .foregroundColor(Color.white)
                    .background(Color.red)
                    .cornerRadius(3)
                }
                Text("$"+(self.value_string))
                    .font(.system(size: 30)).padding(0)
                Spacer()
                Text("Portfolio value")
                    .font(.system(size: 13))
                    .foregroundColor(Color.gray)
                
                Spacer()
                Spacer()
                Button(action: {
                    // What to perform
                    var _: () = API().getAssets(assets: self.user.coins) { coinArray in ()
                
                        self.assetsArray = coinArray;
                        var new_portfolio_value:Double = 0.00;
                        for (coin) in coinArray {
                            new_portfolio_value += (coin.price * coin.amount)

                        }
                        self.portfolio_value = new_portfolio_value;
                        self.value_string = API().formatPrice(price: String(round(100 * self.portfolio_value)/100))
                    };
                }) {
                    Image(systemName: "arrow.clockwise")
                        .font(.system(size: 20))
                        .foregroundColor(Color.gray)
                        .padding(5)
                }
                List {
                    ForEach (0..<self.assetsArray.count, id: \.self)  {i in
                        NavigationLink(destination: SingleCoinView(coin: self.$assetsArray[i],
                                       portfolio_value:
                                        self.$portfolio_value, user: self.$user,
                                       assetsArray: self.$assetsArray)){
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
                            VStack(alignment: .trailing) {
                                Text("$"+API().formatPrice(price:String(self.assetsArray[i].price)))
                                .font(.system(size: 15))
                                Text(String(self.assetsArray[i].amount)).foregroundColor(Color.gray)
                                    .font(.system(size: 13))
                            }
                            .padding(.leading, 30)
                           
                        }
                        .padding(20)
                        .padding(.trailing, 30)
                    }
                    }
                    NavigationLink(destination: AddCoin(portfolio_value: self.$portfolio_value,
                                                        user: self.$user, coins_supported: self.$coins_supported, coins_available: self.$coins_available, assetsArray: self.$assetsArray)){
                        Text("Add Asset")
                    }
                    .buttonStyle(PlainButtonStyle())

                  
                }.onAppear{
                    
                    var _: () = API().getAssets(assets: self.user.coins) { coinArray in ()
                        self.assetsArray = coinArray;
                        var new_portfolio_value:Double = 0.00;
                        for (coin) in coinArray {
                            new_portfolio_value += (coin.price * coin.amount)

                        }
                        self.portfolio_value = new_portfolio_value;
                        self.value_string = API().formatPrice(price: String(round(100 * self.portfolio_value)/100))
                        
                    };
                }
                Spacer()
               
            }   .navigationBarTitle("Home")
            .navigationBarHidden(true)
     
       
        }

    
}



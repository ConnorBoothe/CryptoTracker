//
//  ContentView.swift
//  MyCryptoPortfolio
//
//  Created by Connor Boothe on 12/25/20.
//

import SwiftUI
import NavigationKit
import UIColor_Hex_Swift
class Views: ObservableObject {
    @Published var stacked = false
}
struct ContentView: View {
    
    @ObservedObject var views = Views()
    @State public var assets:Array<Coins> = [Coins(name:"bitcoin", amount:0.8)
]
    @State public var portfolio_value = 0.00;
    @State public var assets_available:Array<Coin> = [];
    @State public var email:String = "";
    @State public var password:String = "";
    @State public var user:User = User(first_name: "", last_name: "", email: "temp", password: "none", coins:[])
    @State var login = false
    @State var loginStatus = true
    @State var coins_supported = ["bitcoin", "ethereum", "litecoin", "dogecoin", "cardano","chainlink"]
    @State public var coins_available:Array<Coin> = []
    func handleSuccessfulLogin() {
      self.login = true
    }
    //controls the ui
    var body: some View {
        NavigationView {
          

        VStack {
            Image(systemName: "globe")
                .font(.system(size: 30))
           
                .padding(30)
            Text("Login")
                .font(.system(size: 30))
                .foregroundColor(Color.black)
                .padding(10)
        
            TextField("example@gmail.com", text: self.$email)
                .font(.system(size: 16))
                .frame(width: 200)
                .foregroundColor(Color.black)
                .background(Color("#d4d4d4"))
                .textFieldStyle(RoundedBorderTextFieldStyle())
            SecureField("password", text: self.$password)
                .font(.system(size: 16))
                .frame(width: 200)
                .foregroundColor(Color.black)
                .background(Color("#d4d4d4"))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom,20)
             Button(action: {
                 // What to perform
                API().getUser(email:self.email.lowercased(), password:self.password) { user in ()
                    self.user = user;
                    if(self.user.first_name != "") {
                        handleSuccessfulLogin();
                        self.email = "";
                        self.password = ""
                    }
                    else {
                        self.loginStatus = false;
                    }
                }
             }) {
                    Text("Login")
             }
             .font(.system(size: 18))
             .frame(width: 120, height: 40)
             .foregroundColor(Color.white)
             .background(Color.blue)
             .cornerRadius(20)
           
            NavigationLink(destination: CreateAccount()){
                Text(String("Create Account"))
                    .padding(10)
            }
            if(!self.loginStatus) {
                VStack{
                    Text("Email or Password Incorrect")
                }
                .cornerRadius(60)
                .padding(20)
                .foregroundColor(Color.red)
               
            }
            Spacer()

            NavigationLink(destination: PostList(portfolio_value: self.$portfolio_value, user: self.$user, login:self.$login, coins_supported: self.$coins_supported, coins_available: self.$coins_available), isActive: self.$login){
                Text(String(self.login))
            }.hidden()
            
Spacer()
        }
        .frame(width: 400)
    }
        .environmentObject(views)
        .navigationBarTitle("")
               .navigationBarHidden(true)

}
}

//
//  CreateAccount.swift
//  MyCryptoPortfolio
//
//  Created by Connor Boothe on 4/10/21.
//

import SwiftUI



struct CreateAccount: View {
    @State public var first_name:String = "";
    @State public var last_name:String = "";
    @State public var email:String = "";
    @State public var password:String = "";
    @State public var userAdded:Bool = false;
    var body: some View {
        VStack {
            
     
        Text("Create Account")
            .font(.system(size: 30))
            .foregroundColor(Color.black)
            .padding(10)
        TextField("First name", text: self.$first_name)
            .font(.system(size: 16))
            .frame(width: 200)
            .foregroundColor(Color.black)
            .background(Color("#d4d4d4"))
            .textFieldStyle(RoundedBorderTextFieldStyle())
        TextField("Last name", text: self.$last_name)
            .font(.system(size: 16))
            .frame(width: 200)
            .foregroundColor(Color.black)
            .background(Color("#d4d4d4"))
            .textFieldStyle(RoundedBorderTextFieldStyle())
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
                API().addUser(first_name: self.first_name, last_name: self.last_name,email:self.email.lowercased(), password:self.password) {
                    user in ()
                    print("it is finished")
                    self.userAdded = true;
                 
                   
               }
            }) {
                   Text("Create Account")
                   
            }
            
            if(self.userAdded == true){
            
                VStack{
                    Text("User added")
                        .font(.headline)
                        .cornerRadius(20)
                        
                }
                .cornerRadius(60)
                .padding(20)
                .frame(width:150, height: 30)
                .background(Color.green)
                .foregroundColor(Color.white)
               
            }
    }
        Spacer()
    }
 
}

//
//  AddCoin.swift
//  MyCryptoPortfolio
//
//  Created by Connor Boothe on 3/26/21.
//

import SwiftUI
struct AddCoinButton: View {

    var body: some View {
        NavigationView {
            
            NavigationLink(destination: AddCoin()){
               
                PostList();
                
            }.buttonStyle(PlainButtonStyle())
//            .navigationBarTitle("Add Coin", displayMode: .automatic)
        }
    }
}

struct AddCoin: View {
    @State private var name: String = "";

    var body: some View {
        Text("Add new asset")
        List{
           
            TextField("Enter asset name", text:$name)
                .foregroundColor(Color.black)
                .padding(20)
                .frame(width: 200, height:50)
                .cornerRadius(20)
            Text(self.name)
            Button(action: {
                // What to perform
               
    //                self.image = URL(string: self.assetsArray[0].image)!;
                    
                
            }) {
                // How the button looks like
                Text("Add Asset")
                    .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                    .cornerRadius(10)
                    .font(.system(size: 16))
            }
            
        }
       

        }
       
}


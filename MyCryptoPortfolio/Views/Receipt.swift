//
//  Receipt.swift
//  MyCryptoPortfolio
//
//  Created by Connor Boothe on 4/15/21.
//

//
//  PricePad.swift
//  MyCryptoPortfolio
//
//  Created by Connor Boothe on 4/13/21.
//

import SwiftUI
import URLImage
struct Receipt: View {
//    @EnvironmentObject var views: Views
    
    @Environment(\.presentationMode) var presentation
    @Binding var coin:Coin
    @Binding var CoinAmount:Double
    @Binding var FiatAmount:String
    @Binding var type:String
//    @State var offset = CGSize.zero
    var body: some View {
        VStack {
            //create number grid
            VStack{
                URLImage(url: coin.image) { image in
                    image
                        .resizable()
                        .frame(width: 100, height: 100)
                        .aspectRatio(1, contentMode: .fit)
                        
                }
                if(self.type == "Sell") {
                    Text("Sale Complete")
                        .font(.title)
                }
                else {
                    
                }
                
                    
            }
            .padding(40)
            VStack{
                Text("\(self.CoinAmount) \(self.coin.ticker)")
                    .font(.largeTitle)
                if(self.type == "Sell") {
                    Text("sold from your account")
                        .font(.system(size: 20))
                }
                else {
                    Text("added to your account")
                        .font(.system(size: 20))
                }
                
            }
            Spacer()
            if(self.type == "Sell") {
                Text("\(self.CoinAmount) \(self.coin.ticker) converted to $\(self.FiatAmount)")
                    .font(.title3)
                    .padding(20)
                    .foregroundColor(Color.white)
            }
            else {
                Text("$\(self.FiatAmount)  converted to \(self.CoinAmount) \(self.coin.ticker)")
                    .font(.title3)
                    .padding(20)
                    .foregroundColor(Color.white)
            }
            
            Button(action: {
//                self.presentation.value.dismiss()
//                self.rootIsActive = true
//                print(self.rootIsActive)

            }) {
                // How the button looks like
                Text("View Portfolio")
                    .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                    .cornerRadius(40)
                    .font(.system(size: 16))
            }
            Spacer()
           
    }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.blue)
        .foregroundColor(Color.white)
        .transition(.move(edge: .bottom))
       
        
        Spacer()
      
    
}

}



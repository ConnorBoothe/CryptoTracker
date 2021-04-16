//
//  PricePad.swift
//  MyCryptoPortfolio
//
//  Created by Connor Boothe on 4/13/21.
//

import SwiftUI

struct PricePad: View {
    @Binding var FiatAmount:String
    @State var DecimalsEntered:Int = 0
    func addNumberToTotal(number:String){
        if(Double(self.FiatAmount)! < 100000) {
            let str = String(self.FiatAmount);
            var chars = Array(str)
            if(self.FiatAmount == "0.00" || self.FiatAmount == "0") {
                self.FiatAmount = number;
            }
            //length - 3 == .
            else if chars.contains(".") {
                if(self.DecimalsEntered < 2){
                    if(self.DecimalsEntered == 0){
                        chars[chars.count-2] = Character(number)
                        self.FiatAmount = String(chars)
                    }
                    else{
                        chars[chars.count-1] = Character(number)
                        self.FiatAmount = String(chars)
                    }
                    self.DecimalsEntered+=1;
                }
            }
           
            else{
                self.FiatAmount += String(number);
            }
        }
        
    }
    func addDecimal(){
        let str = String(self.FiatAmount);
        var chars = Array(str)
        if(self.FiatAmount == "0.00") {
            self.FiatAmount = "0";
        }
        //length - 3 == .
        else if chars.contains(".") {
         if(chars[chars.count-3] == "."){
            chars[chars.count-2] = "0"
            self.FiatAmount = String(chars)
        }
        //length - 3 == .
        else if(chars[chars.count-2] == "."){
            chars[chars.count-1] = "0"
            self.FiatAmount = String(chars)
        }
        }
        else{
            self.FiatAmount += "0";
        }
    }
    func removeIndex(){
        let str = String(self.FiatAmount);
        var chars = Array(str)
        if chars.contains(".") {
           
                if(self.DecimalsEntered == 0){
                    chars.removeLast()
                    chars.removeLast()
                    chars.removeLast()
                    self.FiatAmount = String(chars)
                }
                else if(self.DecimalsEntered == 1){
                    chars[chars.count-2] = "0"
                    self.FiatAmount = String(chars)
                    self.DecimalsEntered-=1;
                }
                else if(self.DecimalsEntered == 2){
                    chars[chars.count-1] = "0"
                    self.FiatAmount = String(chars)
                    self.DecimalsEntered-=1;
                }
           
            print(self.DecimalsEntered)
            
        }
        else {
            if(chars.count > 1) {
                chars.removeLast()
            }
            else {
                chars[0] = "0";
            }
           
            self.FiatAmount = String(chars)
        }
    }
    var body: some View {
        VStack {
            //create number grid
            ForEach(0..<3)  {outerNum in
                HStack{
                ForEach(1..<4)  {innerNum in
                    //1st => inner + 0
                    //2nd inner +1*3
                    //3rd inner +2*3
                        Button(action: {
                            addNumberToTotal(number: String(innerNum + (3 * outerNum)))
                        }) {
                            Text(String(innerNum + (3 * outerNum)))
                                .font(.system(size: 40))
                                .foregroundColor(Color.blue)
                                .padding(20)
                                .frame(width:100)
                    }
                }
            }
            }
            //bottom row of grid
            HStack{
                Button(action: {
                    if(self.FiatAmount != "0.00") {
                        self.FiatAmount += ".00";
                    }
                }) {
                    Text(".")
                        .font(.system(size: 40))
                        .foregroundColor(Color.blue)
                        .padding(20)
                        .frame(width:100)
                }
                Button(action: {
                   addDecimal()
                }) {
                    Text("0")
                        .font(.system(size: 40))
                        .foregroundColor(Color.blue)
                        .padding(20)
                        .frame(width:100)
                }
                Button(action: {
                    removeIndex()
                }) {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 30))
                        .foregroundColor(Color.blue)
                        .padding(20)
                        .frame(width:100)
                }
               
            }
        }
    }
      
    
}


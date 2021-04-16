//
//  Data.swift
//  MyCryptoPortfolio
//
//  Created by Connor Boothe on 12/25/20.
//

import SwiftUI
import Foundation


class API {
    func getAssets( assets:Array<Coins>, priceCompletionHandler: @escaping (Array<Coin>) -> Void){
       
        var coins:Array<Coin> = [];
        //loop through assets and make API call for each asset
        for (coin) in assets {
            //define the headers for the API request
        let headers = [
            "x-rapidapi-key": "66d9a43a5amsh346768cb83dc90bp1bee3ejsn264e836c8915",
            "x-rapidapi-host": "coingecko.p.rapidapi.com"
        ]

            let request = NSMutableURLRequest(url: NSURL(string: "https://coingecko.p.rapidapi.com/coins/\(coin.name.lowercased())?developer_data=true&market_data=true&sparkline=false&community_data=true&localization=true&tickers=true")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        let session = URLSession.shared
        var usd_price = 0.00
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error!)
            } else {
                do {
                    if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                            let coin_description = convertedJsonIntoDict["description"] as? NSDictionary
                            let simple_desc = coin_description!["de"] as! String
                            let coin_name = convertedJsonIntoDict["name"]!;
                            let ticker = convertedJsonIntoDict["symbol"]!;
                            let image_data = convertedJsonIntoDict["image"] as? NSDictionary;
                            let thumbnail = image_data!["large"] as! String;
                            let market_data = convertedJsonIntoDict["market_data"] as? NSDictionary
                            let currPrice = market_data!["current_price"] as? NSDictionary
                                usd_price = currPrice!["usd"] as! Double

                        let newCoin = Coin(name: coin_name as! String, image: URL(string:thumbnail)!, price: usd_price, ticker: ticker as!String, amount:coin.amount, desc: simple_desc);
                            coins.append(newCoin)
                        if(coins.count  == assets.count){
                            priceCompletionHandler(coins);
                        }
                           
                        }
                }
                catch {
                    print(error)
                    print("Err")
                }
            }
        })
        dataTask.resume()
        
     }
    }
    func getMarketData(assets:Array<String>, priceCompletionHandler: @escaping (Array<Coin>) -> Void){
        var coins:Array<Coin> = [];
        //loop through assets and make API call for each asset
        for (coin) in assets {
    
        let headers = [
            "x-rapidapi-key": "66d9a43a5amsh346768cb83dc90bp1bee3ejsn264e836c8915",
            "x-rapidapi-host": "coingecko.p.rapidapi.com"
        ]

            let request = NSMutableURLRequest(url: NSURL(string: "https://coingecko.p.rapidapi.com/coins/\(coin)?developer_data=true&market_data=true&sparkline=false&community_data=true&localization=true&tickers=true")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        let session = URLSession.shared
        var usd_price = 0.00
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error!)
            } else {
                do {
                    if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                        let coin_description = convertedJsonIntoDict["description"] as? NSDictionary
                        let simple_desc = coin_description!["de"] as! String
                        let coin_name = convertedJsonIntoDict["name"]!;
                            let ticker = convertedJsonIntoDict["symbol"]!;
                            let image_data = convertedJsonIntoDict["image"] as? NSDictionary;
                            let thumbnail = image_data!["large"] as! String;
                            let market_data = convertedJsonIntoDict["market_data"] as? NSDictionary
                            let currPrice = market_data!["current_price"] as? NSDictionary
                                usd_price = currPrice!["usd"] as! Double
                        let newCoin = Coin(name: coin_name as! String, image: URL(string:thumbnail)!, price: usd_price, ticker: ticker as!String, amount:0.00, desc: simple_desc);
                            coins.append(newCoin)
                            //needs to complete with an array of coin objects
                        if(coins.count == assets.count) {
                            priceCompletionHandler(coins);
                        }
                        }
                }
                catch {
                    print("Err")
                }
            }
        })
        dataTask.resume()
        
     }
    }
    func formatPrice(price:String)->String{
        //convert price string to array
        var priceArray = Array(price);
        //get index of period
        var index:Int = priceArray.firstIndex(of: ".")!
            //while there are greater than 3 numbers to the left of index
            while(index > 3) {
              index-=3;
                //add comma at index
                priceArray.insert(",", at: index);
            }
        return String(priceArray);
    }
    func getUser(email:String, password:String,completionHandler: @escaping (User) -> Void){
        let request = NSMutableURLRequest(url: NSURL(string: "http://127.0.0.1:8080/API/GetUser/\(email)/\(password)")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error!)
            } else {
                do {
                    if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data!, options: []) as? Array<Any> {
                        if(convertedJsonIntoDict.count > 0) {
                            
                      
                        var user = convertedJsonIntoDict[0] as? NSDictionary;
//                        var first_name = user.first_name;
                        let first_name = user!["first_name"]! as? String
                        let last_name = user!["last_name"]! as? String
                        let email = user!["email"]! as? String
                        let password = user!["password"]! as? String
                       
                        let coins = user!["coins"]! as! Array<NSDictionary>

                        var coin_array:Array<Coins> = [];
                        for (coin) in coins {
                            coin_array.append(Coins(name:coin["name"]! as! String, amount: coin["amount"]! as! Double))
                        }
                        var newUser = User(first_name: first_name!, last_name: last_name!, email: email!, password: password!, coins:coin_array)
                        completionHandler(newUser)
                        }
                        else{
                            var newUser = User(first_name: "", last_name: "", email: "", password: "", coins:[Coins(name:"coin",amount:0.0)])
                            completionHandler(newUser)
                            print("something fucked up. its nil. why lord")
                        }
                        }
                    else{
                        var newUser = User(first_name: "", last_name: "", email: "", password: "", coins:[Coins(name:"coin",amount:0.0)])
                        completionHandler(newUser)
                        print("something fucked up. its nil. why lord")
                    }
                    
                }
                catch {
                    print(error)
                }
                
            }
        })
        dataTask.resume()
        
    }
    func addUser(first_name:String, last_name:String, email:String, password:String,completionHandler: @escaping (String) -> Void){
        let params:[String: String]  = [
            "first_name": first_name,
            "last_name": last_name,
            "email":email,
            "password": password
        ];
        let request = NSMutableURLRequest(url: NSURL(string: "http://127.0.0.1:8080/API/AddUser/")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "POST"
        let jsonData = try? JSONSerialization.data(withJSONObject: params)
        request.httpBody = try? JSONSerialization.data(withJSONObject: params);
        //HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print("error here")
                print(error!)
            } else {
                do {
                    
                    print("added")
                    completionHandler("Done")
                }
                catch {
                    print("error here")
                    print(error)
                }
            }
        })
        dataTask.resume()
        
    }
    func addCoin(name:String, amount:String, email:String, completionHandler: @escaping (Array<Coins>) -> Void){
        let params:[String: String]  = [
            "name": name,
            "amount": amount,
            "email":email
        ];

        let request = NSMutableURLRequest(url: NSURL(string: "http://127.0.0.1:8080/API/AddCoin")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: params);
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print("error here")
                print(error!)
            } else {
                do {

                    if let user = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                    let coins = user["coins"]! as! Array<NSDictionary>
               
                    var new_coin_array:Array<Coins> = [];
                    for (coin) in coins {
                        new_coin_array.append(Coins(name:coin["name"]! as! String, amount: coin["amount"]! as! Double))
                    }
                    completionHandler(new_coin_array)
                    }

                }
                catch {
                    print("error here")
                    print(error)
                }
            }
        })
        dataTask.resume()
        
    }
    func sellCoin(name:String, amount:String, email:String, completionHandler: @escaping (Array<Coins>) -> Void){
        let params:[String: String]  = [
            "name": name,
            "amount": amount,
            "email":email
        ];
        let valid = JSONSerialization.isValidJSONObject(params)
        let request = NSMutableURLRequest(url: NSURL(string: "http://127.0.0.1:8080/API/SellCoin")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: params);
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print("error here")
                print(error!)
            } else {
                do {

                    if let user = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                    let coins = user["coins"]! as! Array<NSDictionary>
               
                    var new_coin_array:Array<Coins> = [];
                    for (coin) in coins {
                        new_coin_array.append(Coins(name:coin["name"]! as! String, amount: coin["amount"]! as! Double))
                    }
                    completionHandler(new_coin_array)
                    }
                }
                catch {
                    print("error here")
                    print(error)
                }
            }
        })
        dataTask.resume()
        
    }
}

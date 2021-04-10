//
//  Data.swift
//  MyCryptoPortfolio
//
//  Created by Connor Boothe on 12/25/20.
//

import SwiftUI
import Foundation


class API {
    func getAssets( assets:KeyValuePairs<String, Double>, priceCompletionHandler: @escaping (Array<Coin>) -> Void){
       
        var coins:Array<Coin> = [];
        //loop through assets and make API call for each asset
        for (key, value) in assets {
            //define the headers for the API request
        let headers = [
            "x-rapidapi-key": "66d9a43a5amsh346768cb83dc90bp1bee3ejsn264e836c8915",
            "x-rapidapi-host": "coingecko.p.rapidapi.com"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://coingecko.p.rapidapi.com/coins/\(key)?developer_data=true&market_data=true&sparkline=false&community_data=true&localization=true&tickers=true")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
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

                        let newCoin = Coin(name: coin_name as! String, image: URL(string:thumbnail)!, price: usd_price, ticker: ticker as!String, amount:value, desc: simple_desc);
                            coins.append(newCoin)
                   
                            priceCompletionHandler(coins);
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
    func getMarketData(assets:KeyValuePairs<String, Double>, priceCompletionHandler: @escaping (Array<Coin>) -> Void){
        var coins:Array<Coin> = [];
        //loop through assets and make API call for each asset
        for (key, value) in assets {
    
        let headers = [
            "x-rapidapi-key": "66d9a43a5amsh346768cb83dc90bp1bee3ejsn264e836c8915",
            "x-rapidapi-host": "coingecko.p.rapidapi.com"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://coingecko.p.rapidapi.com/coins/\(key)?developer_data=true&market_data=true&sparkline=false&community_data=true&localization=true&tickers=true")! as URL,
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
                        var newCoin = Coin(name: coin_name as! String, image: URL(string:thumbnail)!, price: usd_price, ticker: ticker as!String, amount:value, desc: simple_desc);
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
                //decrement index again to account for newly insert comma
                index-=1;
            }
        return String(priceArray);
    }
    func getAllUsers(completionHandler: @escaping (User) -> Void){
        print("get users")
        let request = NSMutableURLRequest(url: NSURL(string: "http://127.0.0.1:8080/API/GetAllUsers")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error!)
            } else {
                do {
                    print(response!)
                    print("doing")
                    if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data!, options: []) as? Array<Any> {
                        var user = convertedJsonIntoDict[0] as? NSDictionary;
//                        var first_name = user.first_name;
                        let first_name = user!["first_name"]! as? String
                        let last_name = user!["last_name"]! as? String
                        let email = user!["email"]! as? String
                        let password = user!["password"]! as? String
                        var newUser = User(first_name: first_name!, last_name: last_name!, email: email!, password: password!)
                        completionHandler(newUser)
                        
                        }
                    else{
                        print("something fucked up. its nil. why lord")
                    }
                }
                catch {
                    print("Err")
                }
            }
        })
        dataTask.resume()
        }
    func getUser(email:String, password:String,completionHandler: @escaping (User) -> Void){
        print("get user")
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
                        var user = convertedJsonIntoDict[0] as? NSDictionary;
//                        var first_name = user.first_name;
                        let first_name = user!["first_name"]! as? String
                        let last_name = user!["last_name"]! as? String
                        let email = user!["email"]! as? String
                        let password = user!["password"]! as? String
                        var newUser = User(first_name: first_name!, last_name: last_name!, email: email!, password: password!)
                        completionHandler(newUser)
                        
                        }
                    else{
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
}

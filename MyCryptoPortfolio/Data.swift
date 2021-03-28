//
//  Data.swift
//  MyCryptoPortfolio
//
//  Created by Connor Boothe on 12/25/20.
//

import SwiftUI
import Foundation
private var assets_supported:Array<String> = ["bitcoin", "ethereum", "litecoin","cardano", "polkadot"]

class API {
    func getAssets( assets:KeyValuePairs<String, Double>, priceCompletionHandler: @escaping (Array<Coin>) -> Void){
        //define the headers for the API request
        //api key && api host
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
                print(error)
            } else {
                do {
                    
                    if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                            let coin_name = convertedJsonIntoDict["name"]!;
                            let ticker = convertedJsonIntoDict["symbol"]!;
                            let image_data = convertedJsonIntoDict["image"] as? NSDictionary;
                            let thumbnail = image_data!["large"] as! String;
                            let market_data = convertedJsonIntoDict["market_data"] as? NSDictionary
                            let currPrice = market_data!["current_price"] as? NSDictionary
                                usd_price = currPrice!["usd"] as! Double
                            var newCoin = Coin(name: key, image: URL(string:thumbnail)!, price: usd_price, ticker: ticker as!String, amount:value);
                            coins.append(newCoin)
                            //needs to complete with an array of coin objects
                        
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
    func getMarketData(priceCompletionHandler: @escaping (Array<Coin>) -> Void){
        var coins:Array<Coin> = [];
        for (coin) in assets_supported {
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
                print(error)
            } else {
                do {
                    if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                            let coin_name = convertedJsonIntoDict["name"]!;
                            let ticker = convertedJsonIntoDict["symbol"]!;
                            let image_data = convertedJsonIntoDict["image"] as? NSDictionary;
                            let thumbnail = image_data!["large"] as! String;
                            let market_data = convertedJsonIntoDict["market_data"] as? NSDictionary
                            let currPrice = market_data!["current_price"] as? NSDictionary
                                usd_price = currPrice!["usd"] as! Double
                        
                        let newCoin = Coin(name: coin_name as! String, image: URL(string:thumbnail)!, price: usd_price, ticker: ticker as!String, amount:0);
                            coins.append(newCoin)
                            //needs to complete with an array of coin objects
                        if(assets_supported[assets_supported.count-1] == coin){
                            priceCompletionHandler(coins);
                        }

            }
                }
                catch {
                    print("err")
                }
            }
        })

        dataTask.resume()
    }

    }
    
}

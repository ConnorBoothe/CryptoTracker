//
//  Data.swift
//  MyCryptoPortfolio
//
//  Created by Connor Boothe on 12/25/20.
//

import SwiftUI
import Foundation

class API {
    func getBitcoin( assets:KeyValuePairs<String, Double>, priceCompletionHandler: @escaping (Array<Coin>) -> Void){
        //define the headers for the API request
        //api key && api host
        var coins:Array<Coin> = [];
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
//                let httpResponse = response as? HTTPURLResponse
                do {
                    if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                                 
                        let coin_name = convertedJsonIntoDict["name"]!;
                        let ticker = convertedJsonIntoDict["symbol"]!;
                        print(ticker)
                        let image_data = convertedJsonIntoDict["image"] as? NSDictionary;
                        let thumbnail = image_data!["large"] as! String;
                        let market_data = convertedJsonIntoDict["market_data"] as? NSDictionary
                        let currPrice = market_data!["current_price"] as? NSDictionary
                            usd_price = currPrice!["usd"] as! Double
                        var newCoin = Coin(name: key, image: thumbnail, price: usd_price, ticker: ticker as!String, amount:value);
                        coins.append(newCoin)
                        print(newCoin)
                        //needs to complete with an array of coin objects
                        priceCompletionHandler(coins);
//                        complete(price: usd_price)
                        }
                    
                 
                }
                catch {
                    print("Err")
                }
            }
        })
        dataTask.resume()
//        return 10.00;
     }
    }
 
}

//
//  Data.swift
//  MyCryptoPortfolio
//
//  Created by Connor Boothe on 12/25/20.
//

import SwiftUI
import Foundation

class API {
    func getBitcoin(priceCompletionHandler: @escaping (Coin) -> Void){
        //define the headers for the API request
        //api key && api host
        print("Make request")
        let headers = [
            "x-rapidapi-key": "66d9a43a5amsh346768cb83dc90bp1bee3ejsn264e836c8915",
            "x-rapidapi-host": "coingecko.p.rapidapi.com"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://coingecko.p.rapidapi.com/coins/bitcoin?developer_data=true&market_data=true&sparkline=false&community_data=true&localization=true&tickers=true")! as URL,
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
                                 
                                 // Print out entire dictionary
//                                 print(convertedJsonIntoDict)
                                 
                                 // Get value by key
                        let image_data = convertedJsonIntoDict["image"] as? NSDictionary;
                        let thumbnail = image_data!["thumb"] as! String;
                        let market_data = convertedJsonIntoDict["market_data"] as? NSDictionary
                        let currPrice = market_data!["current_price"] as? NSDictionary
                            usd_price = currPrice!["usd"] as! Double
                        print(usd_price)
                        var newCoin = Coin(name: "Bitcoin", image: thumbnail, price: usd_price, ticker: "BTC");
                        priceCompletionHandler(newCoin);
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

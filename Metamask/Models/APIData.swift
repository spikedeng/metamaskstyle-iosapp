//
//  APIData.swift
//  Metamask
//
//  Created by Spike Deng on 18/5/2022.
//

import SwiftUI

struct Metrics: Codable, Identifiable {
    var id = UUID()
    var metrics: MetricData
}

struct MetricData: Codable {
    var market_data: MarketData
}

struct MarketData: Codable {
    var price_usd: Float
}

struct APIRes: Codable {
    var data: MetricData
}

class API {
    func getPrice(name: String, completion: @escaping (MarketData) -> ()) {
        print("apistart")
        guard let url = URL(string: "https://data.messari.io/api/v1/assets/\(name)/metrics")
        else {
            print("urlerr")
            return
        }
        print("url", url)
        URLSession.shared.dataTask(with: url) { data, res, error in
            do {
            let resData = try JSONDecoder().decode(APIRes.self, from: data!)
                DispatchQueue.main.async {
                    completion(resData.data.market_data)
                }
            } catch let jsonError as NSError {
                print("jsonerr", jsonError)
            }
                
        }.resume()
    }
}

//
//  APIData.swift
//  Metamask
//
//  Created by Spike Deng on 18/5/2022.
//

import SwiftUI

struct Metrics: Codable, Identifiable {
    var id = UUID()
    var slug: String
    var symbol: String
    var metrics: MetricData?
}

struct MetricData: Codable {
    var market_data: MarketData
}

struct MarketData: Codable {
    var price_usd: Float
}

struct APIMetricsRes: Codable {
    var data: [Metrics]
}

struct APIRes: Codable {
    var data: MetricData
}

class API {
    func getPrice(name: String, completion: @escaping (MarketData) -> ()) {
        
        guard let url = URL(string: "https://data.messari.io/api/v1/assets/\(name)/metrics")
        else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, res, error in
            do {
            let resData = try JSONDecoder().decode(APIRes.self, from: data ?? Data())
                DispatchQueue.main.async {
                    completion(resData.data.market_data)
                }
            } catch let jsonError as NSError {
                print("jsonerr", jsonError)
            }
                
        }.resume()
    }
    
    func getCoinList(completion: @escaping ([Metrics]) -> ()) {
        guard let url = URL(string: "https://data.messari.io/api/v1/assets?fields=id,slug,symbol,metrics/market_data/price_usd")
        else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, res, error in
            do {
            let resData = try JSONDecoder().decode(APIMetricsRes.self, from: data ?? Data())
                DispatchQueue.main.async {
                    completion(resData.data)
                }
            } catch let jsonError as NSError {
                print("jsonerr", jsonError)
            }
                
        }.resume()
    }
}

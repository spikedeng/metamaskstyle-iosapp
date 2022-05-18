//
//  Coins.swift
//  Metamask
//
//  Created by Spike Deng on 18/5/2022.
//

import Foundation

struct Coin: Identifiable {
    let id = UUID().uuidString
    let amount: Double
    let name: String
    let dollar: String
}

let coins = [
    Coin(amount: 3, name: "ETH", dollar: "$4,097.51"),
    Coin(amount: 21, name: "BTC", dollar: "$4.17"),
    Coin(amount: 16, name: "USDC", dollar: "$6.15"),
]

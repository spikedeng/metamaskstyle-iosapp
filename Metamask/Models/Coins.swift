//
//  Coins.swift
//  Metamask
//
//  Created by Spike Deng on 18/5/2022.
//

import Foundation

struct Coin: Identifiable {
    let id = UUID().uuidString
    var amount: Float
    let name: String
    let dollar: String?
}

let defaultCoins = [
    Coin(amount: 3, name: "ETH", dollar: "$4,097.51"),
    Coin(amount: 4, name: "BTC", dollar: "$4.17"),
    Coin(amount: 2, name: "USDC", dollar: "$6.15"),
]

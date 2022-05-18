//
//  TabItems.swift
//  Metamask
//
//  Created by Spike Deng on 18/5/2022.
//

import Foundation

struct TabItem: Identifiable {
    let id = UUID().uuidString
    let title: String
}

let tabItemConfigs = [
    TabItem(title: "TOKENS"),
    TabItem(title: "NFTs")
]

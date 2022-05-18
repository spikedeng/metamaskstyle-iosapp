//
//  MenuItems.swift
//  Metamask
//
//  Created by Spike Deng on 18/5/2022.
//

import Foundation

struct MenuItem: Identifiable {
    let id = UUID().uuidString
    let image: String
    let title: String
}

let menuItems = [
    MenuItem(image: "arrow.down.to.line.alt", title: "Receive"),
    MenuItem(image: "creditcard", title: "Buy"),
    MenuItem(image: "arrow.up.right", title: "Send"),
    MenuItem(image: "arrow.left.arrow.right", title: "Swap")
]

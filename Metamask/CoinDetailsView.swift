//
//  CoinDetailsView.swift
//  Metamask
//
//  Created by Spike Deng on 19/5/2022.
//

import SwiftUI

struct CoinDetailsView: View {
    @State var price: Float = 0
    @State var coinFromHomePage: Coin
    @Binding var walletCoins: [Coin]
    var coinPrices: Dictionary = [String: Float]()
    var body: some View {
        VStack(spacing: 24) {
            CoinDetailsNaviView(coin: coinFromHomePage )
            CoinProfileView(price: price, coin: coinFromHomePage )
            CoinOpsMenuView(coin: $coinFromHomePage, walletCoins: $walletCoins)
            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .frame(height: 1.5)
                .padding(.horizontal, 50)
            Text("No Data")
                .foregroundColor(Color.gray)
                .padding(.top, 50)
            Spacer()
        }
        
        .onAppear(){
            print("coinDetails", coinPrices, coinFromHomePage)
          guard let price1 = coinPrices[coinFromHomePage.name]
            else {return}
            price = price1
        }
        .navigationBarHidden(true)
    }
}

struct CoinOpsMenuView: View {
    @Binding var coin: Coin
    @Binding var walletCoins: [Coin]
    var body: some View {
        HStack(spacing: 8) {
            ForEach(menuItems){ item in
                Button {
                    if(item.title == "Buy") {
                        coin.amount += 1
                        for (index, _) in walletCoins.enumerated() {
                            if(walletCoins[index].name == coin.name) {
                                walletCoins[index].amount += 1
                            }
                        }
                    }
                
                } label: {
                    VStack {
                        Circle()
                            .fill(Color.accentColor)
                            .frame(width: 45, height: 45)
                            .overlay(
                                Image(systemName: item.image)
                                    .foregroundColor(.white)
                            )
                        
                        Text(item.title)
                            .foregroundColor(Color.accentColor)
                            .fontWeight(.medium)
                    }
                }
                .frame(width: 64)
            }
        }
    }
}

struct CoinProfileView: View {
    var price: Float = 0
    var coin: Coin
    
    var body: some View {
        VStack(spacing: 8) {
            Button {
                
            } label: {
                Image(coin.name)
                    .resizable()
                    .aspectRatio( contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .padding(4)
            }
            Text(String(format: "%.2f \(coin.name)", coin.amount))
                .font(.title)
            
            Text(String(format: "$ %.2f ", coin.amount * price))
                .foregroundColor(.gray)
            
        }
        
        
    }
}

struct CoinDetailsNaviView: View {
    var coin:Coin
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        VStack {
            HStack {
                Button (action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "chevron.left")
                        .font(.title)
                })
                Spacer()
                
                VStack(spacing: 4) {
                    Text(coin.name)
                        .font(.title2)
                        .fontWeight(.light)
                    HStack {
                        Circle().fill(Color.green)
                            .frame(width: 8, height: 8)
                        
                        Text("Etherem Main Network")
                            .font(.callout)
                            .fontWeight(.light)
                            .foregroundColor(.gray)
                    }
                }
                Spacer()
                
            }.padding(.horizontal)
            Divider()
            
        }
    }
}

//
//  ContentView.swift
//  Metamask
//
//  Created by Spike Deng on 18/5/2022.
//

import SwiftUI

class WalletCoins: ObservableObject {
    @Published var coins: [Coin]
    init() {
        self.coins = defaultCoins
    }
}

struct ContentView: View {
    
    @State private var selectedIndex: Int = 0
    @State private var owned: [Coin]?
    @State private var wealth: Float = 0

    
    var body: some View {
        NavigationView{
            VStack(spacing: 24) {
                NaviView()
                ProfileView(wealth: $wealth)
                OpsMenuView()
                TabSwitchView(selectedIndex: $selectedIndex, wealth: $wealth)
                Spacer()
                    .navigationBarHidden(true)
            }
        }
//        .environmentObject(self.walletCoins)
    }
}

struct NFTView: View {
    var body: some View {
        VStack(spacing: 8) {
            Image("Space")
                .resizable()
                .frame(width: 40, height: 40)
                .padding(18)
                .clipShape(Circle())
                .aspectRatio(contentMode: .fit)
                .background(Circle().stroke(Color.gray.opacity(0.3), lineWidth: 5))
                .padding(.bottom, 18)
            Text("No NFTs yet")
                .font(.title2)
            Button{
            } label: {
                Text("Learn more")
                    .foregroundColor(Color.accentColor)
            }
        }
    }
}

struct TOKENView: View {
    @State private var walletCoins: [Coin] = defaultCoins
    @State var prices: Dictionary = [String: Float]()
    @Binding var wealth: Float
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack{
                ForEach(walletCoins) { coin in
                    NavigationLink(destination: CoinDetailsView(coinFromHomePage: coin, walletCoins: $walletCoins, coinPrices: prices )){
                        VStack(alignment: .leading) {
                            HStack(spacing: 15) {
                                Image(coin.name)
                                    .resizable()
                                    .frame(width: 40, height:40)
                                    .clipShape(Circle())
                                
                                VStack(alignment: .leading) {
                                    Text(String(format: "%.2f \(coin.name)", coin.amount))
                                        .font(.title2)
                                        .fontWeight(.medium)
                                    
                                    Text("\(prices[coin.name] ?? 0)" )
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                            }
                            .padding(.horizontal)
                            Divider()
                        }
                    }
                    .onAppear(){
                        print("tokenviewappear", walletCoins.count)
                        wealth = 0
                        
                        API().getPrice(name: coin.name) { (metrics) in
                            if(self.prices[coin.name] == nil) {
                                wealth += metrics.price_usd * coin.amount
                            }
                            self.prices[coin.name] = metrics.price_usd
                            print("prices", prices)
                        }
                        for coin in walletCoins {
                            guard let price = prices[coin.name] else {
                                return
                            }
                            wealth += coin.amount * price
                        }
                    }
                }
                
                Text("Don't see your coin")
                    .foregroundColor(Color.gray)
                    .padding(.top, 12)
                NavigationLink(destination: AddCoinView(coins: $walletCoins), label: {
                    Text("Add Coin")
                })
                
            }
            .padding(.top, 12)
            
        }
    }
}

struct TabSwitchView: View {
    @Binding var selectedIndex: Int
    @Binding var wealth: Float
//    @State var coins: [Coin]
    @Namespace var animation
    
    var body: some View {
        VStack(spacing:0){
            HStack{
                ForEach(0 ..< tabItemConfigs.count, id:\.self) { i in VStack {
                    Text(tabItemConfigs[i].title)
                        .foregroundColor(selectedIndex == i ? Color.accentColor : .gray)
                        .fontWeight(selectedIndex == i ? .bold : .light)
                        .frame(maxWidth: .infinity)
                    if selectedIndex == i {
                        Rectangle()
                            .fill(Color.accentColor)
                            .frame(height:3)
                            .matchedGeometryEffect(id: "tab", in: animation)
                    } else {
                        Rectangle()
                            .fill(Color.clear)
                            .frame(height: 2)
                    }
                }
                .onTapGesture {
                    withAnimation{
                        selectedIndex = i
                    }
                }
                }
            }
            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .frame(height: 1.5)
            TabView(selection: $selectedIndex) {
                TOKENView(wealth: $wealth)
                    .tag(0)
                NFTView()
                    .tag(1)
            }
            .tabViewStyle(
                PageTabViewStyle(indexDisplayMode: .never))
        }
        
    }
}

struct OpsMenuView: View {
    var body: some View {
        HStack(spacing: 8) {
            
            ForEach(menuItems){ item in
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
                .frame(width: 80)
            }
        }
    }
}

struct ProfileView: View {
    @Binding var wealth: Float
    
    var body: some View {
        VStack(spacing: 8) {
            Button {
                
            } label: {
                Image("MyAvatar")
                    .resizable()
                    .aspectRatio( contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .padding(4)
                    .background(Circle().stroke(Color.accentColor, lineWidth:3))
            }
            Text("Spike Deng")
                .font(.title)
            
            Text(String(format: "$ %.2f", locale: Locale(identifier: "en"), wealth))
                .foregroundColor(.gray)
            
            Text("0xc944...0497")
                .font(.callout)
                .foregroundColor(.gray)
                .padding(.horizontal, 20)
                .padding(.vertical, 8)
                .background(Capsule().fill(Color.blue.opacity(0.1)))
            
            
        }
        
    }
}

struct NaviView: View {
    var body: some View {
        VStack {
            HStack {
                Button {
                    
                } label: {
                    Image(systemName: "line.horizontal.3")
                        .font(.title)
                }
                Spacer()
                
                VStack(spacing: 4) {
                    Text("Wallet")
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
                
                Button {
                    
                } label: {
                    Image(systemName: "qrcode.viewfinder")
                        .font(.title2)
                }
                
            }.padding(.horizontal)
            Divider()
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.sizeCategory, .medium)
            .previewDevice("iPhone 13")
    }
}

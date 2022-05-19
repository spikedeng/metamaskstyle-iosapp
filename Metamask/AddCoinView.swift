//
//  AddCoinView.swift
//  Metamask
//
//  Created by Spike Deng on 19/5/2022.
//

import SwiftUI

struct AddCoinView: View {
    @Binding var coins: [Coin]
    @State var selectedIndex: Int = 0
    var body: some View {
        VStack{
            AddCoinNaviView()
            AddCoinTabView(selectedIndex: $selectedIndex, walletCoins: $coins)
                .padding(.top, 8)
            Spacer()
        }
        .navigationBarHidden(true)
    }
}

struct AddCoinNaviView: View {
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
                    Text("Add Coin")
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
            
            
        }
    }
}

struct AddCoinTabView: View {
    @Binding var selectedIndex: Int
    @Namespace var animation
    @Binding var walletCoins: [Coin]
    var body: some View {
        VStack(spacing:0){
            HStack{
                ForEach(0 ..< addCoinTabItems.count, id:\.self) { i in VStack {
                    Text(addCoinTabItems[i].title)
                        .foregroundColor(selectedIndex == i ? Color.accentColor : .gray)
                        .fontWeight(.bold)
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
                AddCoinFormView(walletCoins: $walletCoins)
                    .tag(0)
                }
            .tabViewStyle(
                PageTabViewStyle(indexDisplayMode: .never))
        }
        
    }
}

struct AddCoinFormView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @Binding var walletCoins: [Coin]
    @State private var coinname: String = ""
    @State private var matchedMetric: [Metrics] = [Metrics]()
    @State private var metrics: [Metrics] = [Metrics]()
    var body: some View {
        VStack(spacing: 12) {
            HStack{
                Image(systemName: "magnifyingglass")
                    .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 4))
                
                TextField("Search Coin", text: $coinname)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .onChange(of: coinname) { newValue in
                        self.matchedMetric = [Metrics]()
                        for metric in metrics {
//                            print("matching", metric.slug, coinname, metric.slug.contains(coinname))
                            if (metric.slug.contains(coinname) == true) {
                                self.matchedMetric.append(metric)
                            }
                        }
                    }
            }
            .padding(.horizontal, 16)
            .frame( height: 60, alignment: .leading)
            .overlay(RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                .padding(.horizontal, 16)
            )
            .padding(.top, 4)
            if(matchedMetric.count == 0) {
                VStack{
                    List {
                        ForEach(metrics) { metric in
                            Text(metric.slug)
                                .onTapGesture {
                                    self.walletCoins.append(Coin(amount:0, name: metric.symbol, dollar: ""))
                                    self.presentationMode.wrappedValue.dismiss()
                                }
                        }
                        
                    }
                    .listStyle(.plain)
                }
            } else {
                List {
                    ForEach(matchedMetric) { metric in
                        Text(metric.slug)
                    }
                }
                .listStyle(.plain)
            }
            Spacer()
        }
        .onAppear(){
            print("list", walletCoins)
            API().getCoinList { metrics in
                self.metrics = metrics
            }
        }
        .padding(.top, 12)
        
    }
}

struct ConfirmView: View {
    var body: some View {
        HStack(spacing: 12) {
            Button {
                
            } label: {
                Text("Cancel")
                    .frame(maxWidth: .infinity)
                    .foregroundColor(Color.gray)
                    .padding(.leading, 16)
            }
            .frame(height: 50)
            
            .overlay(RoundedRectangle(cornerRadius: 25)
                .stroke(Color.gray.opacity(0.8), lineWidth: 1)
                .padding(.leading, 16)
            )
            
            
            Button {
                
            } label: {
                Text("Add Coin")
                    .frame(maxWidth: .infinity)
                    .padding(.trailing, 16)
            }
            .frame(height: 50)
            //                .padding(.horizontal, 16)
            .overlay(RoundedRectangle(cornerRadius: 25)
                .stroke(Color.accentColor.opacity(0.8), lineWidth: 1)
                .padding(.trailing, 16)
            )
            
        }
    }
}

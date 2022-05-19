//
//  AddCoinView.swift
//  Metamask
//
//  Created by Spike Deng on 19/5/2022.
//

import SwiftUI

struct AddCoinView: View {
    var body: some View {
        VStack{
        AddCoinNaviView()
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
            Divider()
            
        }
    }
}

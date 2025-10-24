//
//  ContentView.swift
//  Set
//
//  Created by Charlie Kalapati on 10/17/25.
//

import SwiftUI

struct SetGameView: View {

    var body: some View {
        Spacer()
        Spacer()
        Text("Set")
            .font(.largeTitle)
            .fontWeight(.bold)
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 90), spacing: 15)], spacing: 15) {
                ForEach(0..<81) { _ in
                    Card()
                        .aspectRatio(2/3, contentMode: .fit)
                }
            }
            .padding(15)
        }
    }
}

struct Card: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(Color.white)
                .shadow(radius: 5)
            VStack {
                Capsule(style: .continuous)
                    .foregroundStyle(Color.blue)
                    .frame(maxWidth: 60, maxHeight: 30)
                    .padding(5)
                Capsule(style: .continuous)
                    .foregroundStyle(Color.blue)
                    .frame(maxWidth: 60, maxHeight: 30)
                    .padding(5)
                Capsule(style: .continuous)
                    .foregroundStyle(Color.blue)
                    .frame(maxWidth: 60, maxHeight: 30)
                    .padding(5)
            }
        }
        
    }
}

#Preview {
    SetGameView()
}

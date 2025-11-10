//
//  SetGameView.swift
//  Set
//
//  Created by Charlie Kalapati on 10/17/25.
//

import SwiftUI

struct SetGameView: View {
    
    var viewModel: SetGameViewModel
    let aspectRatio: CGFloat = 2/3

    var body: some View {
        Spacer()
        Spacer()
        Text("Set")
            .font(.largeTitle)
            .fontWeight(.bold)
        Spacer()
        AspectVGrid(viewModel.cardsDisplayed, aspectRatio: aspectRatio) { card in
            CardView(card)
                .padding(5)
                .onTapGesture {
                    viewModel.select(card.id)
                }
        }
        .padding(15)
        Spacer()
        HStack {
            Spacer()
            Button(action: {
                viewModel.dealMoreCards()
            }, label: {
                Text("Deal 3 More Cards")
            })
            .disabled(viewModel.canDealCards)
            Spacer()
            Button(action: {
                viewModel.newGame()
            }, label: {
                Text("New Game")
            })
            Spacer()
        }
        
    }
}


#Preview {
    SetGameView(viewModel: SetGameViewModel())
}

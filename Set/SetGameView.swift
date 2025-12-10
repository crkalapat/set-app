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
    @Namespace private var dealingNameSpace
    
    struct CardStack: View {
        var cards: [Card]
        var isEmpty: Bool
        var namespace: Namespace.ID
        
        init(of cards: [Card], namespace: Namespace.ID) {
            self.cards = cards
            self.isEmpty = cards.isEmpty
            self.namespace = namespace
        }
        
        @ViewBuilder
        var body: some View {
            if (!isEmpty) {
                ZStack {
                    CardView(Card(), showShadow: false)
                        .aspectRatio(2/3, contentMode: .fit)
                        .frame(maxHeight: 100)
                    ForEach(Array(cards.enumerated()), id: \.offset) { index, card in
                        CardView(card, showShadow: (index == 0))
                            .matchedGeometryEffect(id: card.id, in: namespace)
                            .transition(.asymmetric(insertion: .identity, removal: .identity))
                            .aspectRatio(2/3, contentMode: .fit)
                            .frame(maxHeight: 100)
                    }
                }
            }
        }
    }

    var body: some View {
        VStack {
            Spacer()
            Spacer()
            HStack {
                Spacer()
                Spacer()
                Text("Set")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                Spacer()
                HStack {
                    Spacer()
                    CardStack(of: viewModel.deck, namespace: dealingNameSpace)
                        .zIndex(10)
                        .onTapGesture {
                            if viewModel.canDealCards {
                                withAnimation {
                                    viewModel.dealMoreCards(withAnimation: .snappy(duration: 0.5))
                                }
                            }
                        }
                    Spacer()
                    CardStack(of: viewModel.discarded, namespace: dealingNameSpace)
                    Spacer()
                }
            }
            .padding(15)
            Spacer()
            AspectVGrid(viewModel.cardsDisplayed, aspectRatio: aspectRatio) { card in
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNameSpace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
                    .padding(5)
                    .onTapGesture {
                        withAnimation(.snappy()) {
                            viewModel.select(card.id)
                        }
                    }
            }
            .zIndex(0)
            .padding(15)
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    withAnimation {
                        viewModel.shuffle()
                    }
                }, label: {
                    Text("Shuffle")
                })
                Spacer()
                Button(action: {
                    withAnimation {
                        viewModel.newGame()
                    }
                }, label: {
                    Text("New Game")
                })
                Spacer()
            }
        }
    }
}

#Preview {
    SetGameView(viewModel: SetGameViewModel())
        .preferredColorScheme(.light)
}

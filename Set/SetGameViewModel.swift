//
//  SetGameViewModel.swift
//  Set
//
//  Created by Charlie Kalapati on 10/29/25.
//

import SwiftUI

@Observable class SetGameViewModel {
    
    var game: SetGame
    var deck: [Card] {
        game.deck
    }
    var discarded: [Card] {
        game.discarded
    }
    var cardsDisplayed: [Card] {
        game.cards
    }
    var canDealCards: Bool {
        !game.deck.isEmpty
    }
    
    init() {
        game = SetGame()
    }
    
    func newGame() {
        game.newGame()
        for _ in 0..<12 {
            game.dealCard()
        }
    }
    
    func select(_ cardId: Card.ID) {
        game.select(cardID: cardId)
    }
    
    func dealMoreCards(withAnimation animation: Animation, interval: TimeInterval = 0.25) {
        var delay: TimeInterval = 0
        for _ in 0..<3 {
            withAnimation(animation.delay(delay)) {
                game.dealCard()
            }
            delay += interval
        }
    }
    
    func shuffle() {
        game.shuffle()
    }
}

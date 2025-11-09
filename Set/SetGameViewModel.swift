//
//  SetGameViewModel.swift
//  Set
//
//  Created by Charlie Kalapati on 10/29/25.
//

import SwiftUI

@Observable class SetGameViewModel {
    var numCardsDisplayed = 12
    var game: SetGame
    var cardsDisplayed: [Card] {
        game.cards
    }
    var canDealCards: Bool {
        game.deck.isEmpty
    }
    
    init() {
        game = SetGame()
    }
    
    func newGame() {
        game = SetGame()
    }
    
    func select(_ cardId: Card.ID) {
        game.select(cardID: cardId)
    }
    
    func dealMoreCards() {
        game.dealMoreCards()
    }
}

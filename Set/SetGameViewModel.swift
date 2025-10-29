//
//  SetGameViewModel.swift
//  Set
//
//  Created by Charlie Kalapati on 10/29/25.
//

import SwiftUI

@Observable
class SetGameViewModel {
    var numCardsDisplayed = 12
    var game: SetGame
    var cardsDisplayed: [Card] {
        Array(game.cards[0..<numCardsDisplayed])
    }
    
    init() {
        game = SetGame()
    }
    
    func newGame() {
        game = SetGame()
    }
    
    func dealMoreCards() {
        if (game.isSet(game.selectedCardIndices)) {
            
        } else {
            numCardsDisplayed += 3
        }
    }
}

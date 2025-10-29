//
//  SetGame.swift
//  Set
//
//  Created by Charlie Kalapati on 10/27/25.
//

import Foundation

struct SetGame {
    private(set) var cards: [Card]
    private(set) var selectedCardIndices: [Int] = []
    
    init() {
        var newCards: [Card] = []
        for color in CardColor.allCases {
            for shape in CardShape.allCases {
                for shade in CardShade.allCases {
                    for count in 1...3 {
                        newCards.append(Card(shape: shape, color: color, symbolCount: count, shading: shade))
                    }
                }
            }
        }
        newCards.shuffle()
        cards = newCards
    }
    
    func isSet(_ card1: Card, _ card2: Card, _ card3: Card) -> Bool {
        if isSameOrDifferent(card1.color, card2.color, card3.color)
            && isSameOrDifferent(card1.shape, card2.shape, card3.shape)
            && isSameOrDifferent(card1.symbolCount, card2.symbolCount, card3.symbolCount) {
            
            return true
        }
        return false
    }
    
    func isSet(_ indices: [Int]) -> Bool {
        if indices.count == 3 {
            if isSameOrDifferent(cards[indices[0]].color, cards[indices[1]].color, cards[indices[2]].color)
                && isSameOrDifferent(cards[indices[0]].shape, cards[indices[1]].shape, cards[2].shape)
                && isSameOrDifferent(cards[indices[0]].symbolCount, cards[indices[1]].symbolCount, cards[indices[2]].symbolCount) {
                
                return true
            }
        }
        return false
    }
    
    func isSameOrDifferent<T: Equatable>(_ value1: T, _ value2: T, _ value3: T) -> Bool {
        return ((value1 == value2) && (value2 == value3)) ||
            (((value1 != value2) && (value2 != value3)) && (value1 != value3))
    }
    
    mutating func choose(card: Card) {
        if selectedCardIndices.count == 3 {
            refreshCards()
        }
        if selectedCardIndices.count < 3 {
            if let cardIndex = cards.firstIndex(of: card) {
                selectedCardIndices.append(cardIndex)
            }
            if selectedCardIndices.count == 3 {
                if isSet(selectedCardIndices) {
                    for selectedIndex in selectedCardIndices {
                        cards[selectedIndex].isMatched = true
                    }
                }
            }
        }
    }
    
    mutating func refreshCards() {
        let oldSelectedCardIndices = selectedCardIndices
        for selectedIndex in selectedCardIndices {
            cards.remove(at: selectedIndex)
        }
    }

}

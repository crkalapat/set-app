//
//  SetGame.swift
//  Set
//
//  Created by Charlie Kalapati on 10/27/25.
//

import Foundation

struct SetGame {
    let cards: [Card]
    
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
    
    func isSameOrDifferent<T: Equatable>(_ value1: T, _ value2: T, _ value3: T) -> Bool {
        return ((value1 == value2) && (value2 == value3)) ||
            (((value1 != value2) && (value2 != value3)) && (value1 != value3))
    }

}

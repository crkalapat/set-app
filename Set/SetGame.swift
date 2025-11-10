//
//  SetGame.swift
//  Set
//
//  Created by Charlie Kalapati on 10/27/25.
//

import Foundation

struct SetGame {
    private(set) var deck: [Card]
    private(set) var cards: [Card] = []
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
        deck = newCards
        
        for _ in 0..<12 {
            cards.append(deck.removeFirst())
        }
    }
    
    func isSet(_ indices: [Int]) -> Bool {
        if indices.count == 3 {
            if (isSameOrDifferent(cards[indices[0]].color, cards[indices[1]].color, cards[indices[2]].color) && isSameOrDifferent(cards[indices[0]].shape, cards[indices[1]].shape, cards[indices[2]].shape)) && (isSameOrDifferent(cards[indices[0]].symbolCount, cards[indices[1]].symbolCount, cards[indices[2]].symbolCount) && isSameOrDifferent(cards[indices[0]].shading, cards[indices[1]].shading, cards[indices[2]].shading)) {
                return true
            }
        }
        return false
    }
    
    func isSameOrDifferent<T: Equatable>(_ value1: T, _ value2: T, _ value3: T) -> Bool {
        return ((value1 == value2) && (value2 == value3)) ||
            (((value1 != value2) && (value2 != value3)) && (value1 != value3))
    }
    
    mutating func select(cardID id: Card.ID) {
        if let _ = cards.firstIndex(where: { $0.id == id }) {
            if selectedCardIndices.count == 3 {
                refreshCards()
            }
        }
        if let cardIdx = cards.firstIndex(where: { $0.id == id }) {
            guard let _ = cards[cardIdx].isMatched else {
                if cards[cardIdx].isSelected && selectedCardIndices.count < 3 {
                    cards[cardIdx].isSelected = false
                    if selectedCardIndices.contains(cardIdx) {
                        selectedCardIndices.remove(at: selectedCardIndices.firstIndex(of: cardIdx)!)
                    }
                } else if !cards[cardIdx].isSelected {
                    if selectedCardIndices.count < 3 {
                        cards[cardIdx].isSelected = true
                        selectedCardIndices.append(cardIdx)
                        if selectedCardIndices.count == 3 {
                            if isSet(selectedCardIndices) {
                                selectedCardIndices.forEach { index in
                                    cards[index].isMatched = true
                                }
                            } else {
                                selectedCardIndices.forEach { index in
                                    cards[index].isMatched = false
                                }
                            }
                        }
                    }
                }
                return
            }
        }
    }
    
    mutating func dealMoreCards() {
        if isSet(selectedCardIndices) {
            selectedCardIndices.forEach { index in
                replaceCard(at: index)
            }
            selectedCardIndices.removeAll()
        } else {
            if deck.count >= 3 {
                for _ in 0..<3 {
                    dealCard()
                }
            } else {
                for _ in 0..<deck.count {
                    dealCard()
                }
            }
        }
    }
    
    mutating func replaceCard(at index: Int) {
        if !deck.isEmpty {
            cards[index] = deck.removeFirst()
        } else {
            if index < cards.count {
                cards.remove(at: index)
            }
        }
    }
    
    mutating func dealCard() {
        if !deck.isEmpty {
            cards.append(deck.removeFirst())
        }
    }

    mutating func refreshCards() {
        if isSet(selectedCardIndices) {
            selectedCardIndices.sort(by: >)
            for index in selectedCardIndices {
                replaceCard(at: index)
            }
        } else {
            selectedCardIndices.forEach { index in
                cards[index].isSelected = false
                cards[index].isMatched = nil
            }
        }
        selectedCardIndices.removeAll()
    }

}

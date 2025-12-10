//
//  Card.swift
//  Set
//
//  Created by Charlie Kalapati on 10/27/25.
//

import Foundation

struct Card: Equatable, Hashable, Identifiable {
    init(shape: CardShape, color: CardColor, symbolCount: Int, shading: CardShade, isMatched: Bool? = nil, isFaceUp: Bool = false, isSelected: Bool = false) {
        self.shape = shape
        self.color = color
        self.symbolCount = symbolCount
        self.shading = shading
        self.isMatched = isMatched
        self.isSelected = isSelected
        self.isFaceUp = isFaceUp
    }
    
    init() {
        self.shape = .capsule
        self.color = .blue
        self.symbolCount = 0
        self.shading = .solid
        self.isMatched = nil
        self.isSelected = false
        self.isFaceUp = true
    }
    
    let shape: CardShape
    let color: CardColor
    let symbolCount: Int
    let shading: CardShade
    var isMatched: Bool? = nil
    var isSelected = false
    private(set) var isFaceUp = false
    private(set) var id: UUID = UUID()
    
    mutating func flip() {
        isFaceUp.toggle()
    }
}

enum CardColor: CaseIterable {
    case blue
    case red
    case green
}

enum CardShade: CaseIterable {
    case solid
    case tinted
    case stroked
}

enum CardShape: CaseIterable {
    case rectangle
    case capsule
    case diamond
}

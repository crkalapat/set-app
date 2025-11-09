//
//  Card.swift
//  Set
//
//  Created by Charlie Kalapati on 10/27/25.
//

import Foundation

struct Card: Equatable, Hashable, Identifiable {
    init(shape: CardShape, color: CardColor, symbolCount: Int, shading: CardShade, isMatched: Bool? = nil, isSelected: Bool = false) {
        self.shape = shape
        self.color = color
        self.symbolCount = symbolCount
        self.shading = shading
        self.isMatched = isMatched
        self.isSelected = isSelected
    }
    
    let shape: CardShape
    let color: CardColor
    let symbolCount: Int
    let shading: CardShade
    var isMatched: Bool? = nil
    var isSelected = false
    var id: UUID = UUID()
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

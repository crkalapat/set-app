//
//  Card.swift
//  Set
//
//  Created by Charlie Kalapati on 10/27/25.
//

struct Card {
    let shape: CardShape
    let color: CardColor
    let symbolCount: Int
    let shading: CardShade
}

enum CardColor: CaseIterable {
    case blue
    case red
    case green
}

enum CardShade: CaseIterable {
    case solid
    case tinted
    case clear
}

enum CardShape: CaseIterable {
    case rectangle
    case capsule
    case diamond
}

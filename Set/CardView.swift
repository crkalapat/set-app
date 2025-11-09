//
//  CardView.swift
//  Set
//
//  Created by Charlie Kalapati on 11/1/25.
//

import SwiftUI

struct CardView: View, Identifiable {
    let card: Card
    var id: UUID
    
    init(_ card: Card) {
        self.card = card
        self.id = UUID()
    }
        
    func getColor() -> Color {
        switch card.color {
        case .blue:
            return .blue
        case .green:
            return .green
        case .red:
            return .red
        }
    }
    
    func getShape() -> AnyShape {
        switch card.shape {
        case .capsule:
            AnyShape(Capsule(style: .continuous))
        case .rectangle:
            AnyShape(Rectangle())
        case .diamond:
            AnyShape(Diamond())
        }
    }
    
    func getShadowColor() -> Color {
        guard let _ = card.isMatched else {
            return card.isSelected ? .yellow : .gray
        }
        if let matched = card.isMatched {
            if matched {
                return .green
            } else {
                return .red
            }
        }
        return .blue
    }
        
    @ViewBuilder func styledShape<S: Shape>(_ content: S) -> some View {
        switch card.shading {
        case .solid:
            content
                .fill(getColor())
        case .stroked:
            content
                .stroke(getColor(), lineWidth: 7)
                .fill(Color.white)
        case .tinted:
            content
                .fill(getColor().opacity(0.5))
        }
    }
    
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(Color.white)
                    .shadow(color: getShadowColor(), radius: 5)
                VStack {
                    ForEach(0..<card.symbolCount, id: \.self) { _ in
                        styledShape(getShape())
                            .frame(maxWidth: geometry.size.width * 0.5, maxHeight: geometry.size.height * 0.15)
                            .padding(5)
                    }
                }
            }
        }
    }
}


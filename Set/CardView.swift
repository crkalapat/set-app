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
    var showShadow = true
    var cardColor: Color {
        get {
            if card.isFaceUp {
                guard let _ = card.isMatched else {
                    // yellow : white
                    return card.isSelected ? Color(hex: 0xd9f3ff) : .white
                }
                if let matched = card.isMatched {
                    if matched {
                        return Color(hex: 0x4dfa87) // green
                    } else {
                        return Color(hex: 0xeb7579) // red
                    }
                }
                return .pink
            } else {
                return .indigo
            }
        }
    }
    
    init(_ card: Card, showShadow: Bool = true) {
        self.card = card
        self.id = UUID()
        self.showShadow = showShadow
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
    
    mutating func disableShadow() {
        showShadow = false
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
        
    @ViewBuilder func styledShape<S: Shape>(_ content: S) -> some View {
        switch card.shading {
        case .solid:
            content
                .fill(getColor())
        case .stroked:
            content
                .stroke(getColor(), lineWidth: 3)
                .fill(Color.clear)
        case .tinted:
            content
                .fill(getColor().opacity(0.5))
        }
    }
    
    struct shadowBackground: ViewModifier {
        var showShadow: Bool
        
        init(_ showShadow: Bool) {
            self.showShadow = showShadow;
        }
        
        @ViewBuilder
        func body(content: Content) -> some View {
            if (showShadow) {
                content
                    .shadow(color: .gray, radius: 5)
            } else {
                content
            }
        }
    }
    
    @ViewBuilder
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(cardColor)
                    .modifier(shadowBackground(showShadow))
                if (card.isFaceUp) {
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
}

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}

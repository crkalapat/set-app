//
//  Diamond.swift
//  Set
//
//  Created by Charlie Kalapati on 11/8/25.
//

import CoreGraphics
import SwiftUI

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let width: CGFloat = rect.width
        let height: CGFloat = rect.height
        let top = CGPoint(x: center.x, y: center.y - height / 2)
        let right = CGPoint(x: center.x - width / 2, y: center.y)
        let left = CGPoint(x: center.x + width / 2, y: center.y)
        let bottom = CGPoint(x: center.x, y: center.y + height / 2)
        
        var p = Path()
        p.move(to: top)
        p.addLine(to: left)
        p.addLine(to: bottom)
        p.addLine(to: right)
        p.closeSubpath()
        
        return p
    }
}

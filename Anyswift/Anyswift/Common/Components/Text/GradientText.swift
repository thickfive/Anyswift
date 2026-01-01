//
//  GradientText.swift
//  Anyswift
//
//  Created by vvii on 2025/12/26.
//

import SwiftUI

public protocol TextGradient: View {
    var id: UUID { get }
}

public extension TextGradient {
    var id: UUID { UUID() }
}

extension AnyGradient: TextGradient, @retroactive View {}
extension LinearGradient: TextGradient {}
extension RadialGradient: TextGradient {}
extension AngularGradient: TextGradient {}
extension EllipticalGradient: TextGradient {}

public struct GradientText: View {
    let text: String
    var font: Font = .title
    var gradients: [any TextGradient] = []
    
    public init(_ text: String) {
        self.text = text
    }
    
    public var body: some View {
        Text(text)
            .font(font)
            .foregroundStyle(.clear)
            .overlay(
                ZStack {
                    ForEach(gradients, id: \.id) {
                        AnyView($0)
                    }
                }
            )
            .mask(
                Text(text)
                    .font(font)
            )
    }
}

public extension GradientText {
    func font(_ font: Font) -> Self {
        var copy = self
        copy.font = font
        return copy
    }
    
    func gradient(_ gradient: any TextGradient) -> Self {
        var copy = self
        copy.gradients.append(gradient)
        return copy
    }
    
    func gradient(colors: [Color], startPoint: UnitPoint = .leading, endPoint: UnitPoint = .trailing) -> Self {
        var copy = self
        copy.gradients.append(LinearGradient(gradient: Gradient(colors: colors), startPoint: startPoint, endPoint: endPoint))
        return copy
    }
    
    func gradient(stops: [Gradient.Stop], startPoint: UnitPoint = .leading, endPoint: UnitPoint = .trailing) -> Self {
        var copy = self
        copy.gradients.append(LinearGradient(gradient: Gradient(stops: stops), startPoint: startPoint, endPoint: endPoint))
        return copy
    }
}


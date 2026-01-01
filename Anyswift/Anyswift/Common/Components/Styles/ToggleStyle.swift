//
//  Checkbox.swift
//  Anyswift
//
//  Created by vvii on 2025/12/26.
//

import SwiftUI

public struct CheckboxToggleStyle: ToggleStyle {
    public func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }, label: {
            HStack {
                Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                    .foregroundStyle(.black)
                configuration.label
            }
        })
    }
}

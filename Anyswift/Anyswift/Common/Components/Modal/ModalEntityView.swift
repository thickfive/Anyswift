//
//  ModalEntityView.swift
//  Anyswift
//
//  Created by vvii on 2025/12/26.
//

import SwiftUI

public struct ModalEntityView: View {
    @ObservedObject var viewModel: ModalEntityViewModel
    
    public var body: some View {
        ZStack(alignment: viewModel.entity.alignment) {
            Color.clear
            if viewModel.isInsertion {
                AnyView(viewModel.entity.content)
                    .transition(.asymmetric(insertion: viewModel.entity.insertionTransition, removal: viewModel.entity.removalTransition))
            }
        }
        .animation(viewModel.entity.animation, value: viewModel.isInsertion)
    }
}

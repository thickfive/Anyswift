//
//  WebView.swift
//  Anyswift
//
//  Created by vvii on 2025/12/26.
//

import SwiftUI
import WebKit

public struct WebView: View {
    @StateObject private var viewModel: WebViewModel
    let url: String
    
    public init(url: String) {
        self.url = url
        _viewModel = StateObject(wrappedValue: WebViewModel(url: url))
    }
    
    public var body: some View {
        NavigationPageView(
            title: viewModel.title,
            contentView: {
                WebKitView(viewModel: viewModel)
            }
        )
    }
}

struct WebKitView: UIViewControllerRepresentable {
    typealias UIViewControllerType = WebKitViewController
    
    let viewModel: WebViewModel
    
    func makeUIViewController(context: Context) -> WebKitViewController {
        let vc = WebKitViewController(viewModel: viewModel)
        return vc
    }
    
    func updateUIViewController(_ uiViewController: WebKitViewController, context: Context) {
        //
    }
}

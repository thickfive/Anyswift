//
//  ContentView16.swift
//  AnySwift
//
//  Created by vvii on 2026/1/1.
//

#if AVAILABLE_IOS_16
import SwiftUI

@available(iOS 16.0, *)
struct ContentView16: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: SymbolCategoryListView()) {
                    Text("SF Symbols")
                }
                NavigationLink(destination: HighlightSwift_CodeText()) {
                    Text("HighlightSwift_CodeText")
                }
                NavigationLink(destination: MarkdownViews()) {
                    Text("MarkdownViews")
                }
                NavigationLink(destination: HtmlToAttributedString()) {
                    Text("HtmlToAttributedString")
                }
            }
            .navigationTitle("Packages")
            .navigationBarTitleDisplayMode(.automatic)
        }
    }
}
#endif

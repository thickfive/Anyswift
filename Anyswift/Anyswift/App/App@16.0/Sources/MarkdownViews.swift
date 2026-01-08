//
//  MarkdownViews.swift
//  Anyswift
//
//  Created by vvii on 2026/1/5.
//

#if AVAILABLE_IOS_16
import SwiftUI

fileprivate extension View {
    func injectOpenURLAction() -> some View {
        self.environment(\.openURL, OpenURLAction { url in
            Log.info("clicked: \(url)")
            return .handled
        })
    }
}

struct MarkdownViews: View {
    let markdownString = """
      ## Try MarkdownUI  
      ![Image](https://tp.yujianliao.com/android_104559_20251125_080750_7799765.jpg?imageView2/2/w/200/h/200)  
      **MarkdownUI** is a native Markdown renderer for SwiftUI
      compatible with the
      [GitHub Flavored Markdown Spec](https://github.github.com/gfm/).
      """
    
    var body: some View {
        List {
            NavigationLink(destination: MarkdownUI_Markdown(markdown: markdownString)) {
                Text("MarkdownUI_Markdown")
            }
            NavigationLink(destination: Text(LocalizedStringKey(markdownString))) {
                Text("Text(LocalizedStringKey(_:))")
            }
            NavigationLink(destination: Text(try! AttributedString(markdown: markdownString))) {
                Text("Text(try! AttributedString(markdown:))")
            }
        }
        .navigationTitle("MarkdownViews")
    }
}
#endif

#if AVAILABLE_IOS_16
import MarkdownUI

struct MarkdownUI_Markdown: View {
    let markdown: String

    var body: some View {
        VStack {
            Markdown(markdown)
            Divider()
            Markdown {
                """
                ## Using a Markdown Content Builder
                Use Markdown strings or an expressive domain-specific language
                to build the content.
                """
                Heading(.level2) {
                    "Try MarkdownUI"
                }
                Paragraph {
                    Strong("MarkdownUI")
                    " is a native Markdown renderer for SwiftUI"
                    " compatible with the "
                    InlineLink(
                        "GitHub Flavored Markdown Spec",
                        destination: URL(string: "https://github.github.com/gfm/")!
                    )
                    "."
                }
            }
        }
    }
}
#endif

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

#if AVAILABLE_IOS_16
import SwiftUI
import HighlightSwift

struct HighlightSwift_CodeText: View {
    let code = """
    import SwiftUI
    
    struct ContentView: View {
        @State private var message = "Hello, SwiftUI!"
        
        var body: some View {
            VStack {
                Text(message)
                    .font(.title)
                    .padding()
                
                Button("Update") {
                    message = "Syntax Highlighting Works!"
                }
            }
            .padding()
        }
    }
    
    #Preview {
        ContentView()
    }
    """
    
    var body: some View {
        if #available(iOS 16.1, *) {
            CodeText(code)
                .codeTextStyle(.card)
                .font(.system(size: 14))
        } else {
            Text(code)
        }
    }
}
#endif

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

#if AVAILABLE_IOS_16
import SwiftUI

struct HtmlToAttributedString: View {
    /// 支持完整 html
    let htmlString1 = """
    <!DOCTYPE html>
    <html>
    <head>
        <meta charset="utf-8">
        <style type="text/css">
            body {
                font-family: -apple-system, BlinkMacOSystemFont, "Segoe UI", Roboto, sans-serif;
                font-size: 16px;
                line-height: 1.5;
                color: #333;
                margin: 8px;
            }
            h1, h2, h3 { color: #1a1a1a; }
            a {
                color: #0066cc;
                text-decoration: none;
            }
            a:hover {
                text-decoration: underline;
            }
            .highlight {
                background-color: #fff3cd;
                padding: 2px 6px;
                border-radius: 4px;
            }
            ul, ol {
                margin-left: 20px;
            }
            code {
                font-family: Menlo, Monaco, Consolas, "Courier New", monospace;
                background-color: #f5f5f5;
                padding: 2px 5px;
                border-radius: 3px;
            }
        </style>
    </head>
    <body>
        <h2>這是標題</h2>
        <p>這是一段<strong>重要</strong>的內容，帶有 <a href="https://example.com">連結</a></p>
        <p class="highlight">這段有特別背景色</p>
        <ul>
            <li>項目一</li>
            <li>項目二 <code>code</code></li>
        </ul>
    </body>
    </html>
    """

    /// 支持正文 + 内联 css
    let htmlString2 = """
    <h3>最新消息 🚀</h3>
    <p>Swift 6.0 已正式發布！詳見 <a href="https://developer.apple.com/swift/">官方文件</a></p>
    <p>想學更多？<a href="https://github.com/HackingwithSwift">Hacking with Swift</a> 超讚！</p>
    <ul>
        <li>閱讀 <a href="mailto:hello@example.com">聯絡我們</a></li>
        <li>下載 <a href="https://apps.apple.com/app/id123456789">App</a></li>
    </ul>
    <p style="color: #e74c3c;">內部連結：<a href="https://www.baidu.com">百度</a></p>
    """
    
    /// 支持正文 + 嵌入 css
    let htmlString3 = """
    <style type="text/css">
        body { font-size: 16px; line-height: 1.6; }
        p { margin: 0 0 12px; }
        a { color: #00ff00; }
    </style>
    <h2>標題</h2>
    <p>內容內容 <a href="https://www.baidu.com">百度</a></p>
    """
    
    var htmlString: String {
        return htmlString2
    }

    var body: some View {
        Text(AttributedString(htmlString.htmlToAttributedString() ?? NSAttributedString(string: htmlString)))
    }
}

extension String {
    /// HTML → NSAttributedString，支持超链接 + 自訂字體
    func htmlToAttributedString(baseFont: UIFont = .systemFont(ofSize: 16)) -> NSAttributedString? {
        guard let data = self.data(using: .utf8) else { return nil }
        
        do {
            let attrString = try NSAttributedString(
                data: data,
                options: [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding: String.Encoding.utf8.rawValue
                ],
                documentAttributes: nil
            )
            
            // 轉成 NSMutableAttributedString 來修正字體
            let mutableAttr = NSMutableAttributedString(attributedString: attrString)
            let range = NSRange(location: 0, length: mutableAttr.length)
            
            // 統一字體大小，但保留顏色、粗體、超連結等
            mutableAttr.enumerateAttribute(.font, in: range) { value, subrange, _ in
                guard let htmlFont = value as? UIFont else { return }
                // let traits = UIFontDescriptor.TraitMask(rawValue: 0)
                let newFont = baseFont.withSize(htmlFont.pointSize)
                mutableAttr.addAttribute(.font, value: newFont, range: subrange)
            }
            
            // // 確保超連結可點擊（通常自動有，但可強制設定）
            // mutableAttr.enumerateAttribute(.link, in: range) { value, subrange, _ in
            //     guard let urlString = value as? String,
            //           let _ = URL(string: urlString) else { return }
            //     
            //     // 可選：自訂連結顏色或樣式
            //     mutableAttr.addAttribute(.foregroundColor,
            //                            value: UIColor.systemBlue,
            //                            range: subrange)
            //     mutableAttr.addAttribute(.underlineStyle,
            //                            value: NSUnderlineStyle.single.rawValue,
            //                            range: subrange)
            // }
            
            return mutableAttr
        } catch {
            print("轉換失敗: \(error)")
            return nil
        }
    }
}
#endif

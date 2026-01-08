//
//  HtmlToAttributedString.swift
//  Anyswift
//
//  Created by vvii on 2026/1/5.
//

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

    var body: some View {
        ScrollView {
            VStack {
                Text(AttributedString(htmlString1.htmlToAttributedString() ?? NSAttributedString(string: htmlString1)))
                Divider()
                Text(AttributedString(htmlString2.htmlToAttributedString() ?? NSAttributedString(string: htmlString2)))
                Divider().frame(height: 0.5)
                Text(AttributedString(htmlString3.htmlToAttributedString() ?? NSAttributedString(string: htmlString3)))
            }
        }
    }
}

extension String {
    /// HTML 转换为 NSAttributedString，支持超链接 + 自定义字体
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
            
            //（可选）转成 NSMutableAttributedString 来修正字体
            let mutableAttr = NSMutableAttributedString(attributedString: attrString)
            let range = NSRange(location: 0, length: mutableAttr.length)
            //（可选）统一字体与大小
            mutableAttr.addAttribute(.font, value: baseFont, range: range)
            
            //（可选）统一字体，但保留原字体大小
            mutableAttr.enumerateAttribute(.font, in: range) { value, subrange, _ in
                guard let htmlFont = value as? UIFont else { return }
                let newFont = baseFont.withSize(htmlFont.pointSize)
                mutableAttr.addAttribute(.font, value: newFont, range: subrange)
            }
            
            mutableAttr.enumerateAttribute(.link, in: range) { value, subrange, _ in
                guard let _ = value as? URL else { return }
                //（可选）自定义链接颜色
                mutableAttr.addAttribute(.foregroundColor,
                                       value: UIColor.systemBlue,
                                       range: subrange)
                //（可选）自定义链接下划线
                mutableAttr.addAttribute(.underlineStyle,
                                       value: NSUnderlineStyle.single.rawValue,
                                       range: subrange)
            }
            
            return mutableAttr
        } catch {
            print("转换失败: \(error)")
            return nil
        }
    }
}
#endif


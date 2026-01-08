//
//  HighlightSwift_CodeText.swift
//  Anyswift
//
//  Created by vvii on 2026/1/5.
//

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


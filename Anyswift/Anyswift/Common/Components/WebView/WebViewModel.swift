//
//  WebViewModel.swift
//  Anyswift
//
//  Created by vvii on 2025/12/26.
//

import Foundation
import Combine

@MainActor
class WebViewModel: ObservableObject {
    let url: String
    @Published var title: String
    
    init(url: String, title: String = "") {
        self.title = title
        self.url = url
    }
}

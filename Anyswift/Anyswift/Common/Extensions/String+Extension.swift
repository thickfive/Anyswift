//
//  String+Extension.swift
//  Anyswift
//
//  Created by vvii on 2025/12/26.
//

import Foundation

public extension String {
    func isValid(_ regex: Regex<Substring>) -> Bool {
        if let _ = try? regex.wholeMatch(in: self) {
            return true
        }
        return false
    }
}


//
//  Date+Extension.swift
//  Anyswift
//
//  Created by vvii on 2025/12/26.
//

import Foundation

public extension DateFormatter {
    static let shared: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = ""
        formatter.locale = Locale(identifier: "en_US")
        formatter.timeZone = Locale.current.timeZone
        return formatter
    }()
}

public extension Date {
    func formatted(_ format: DateFormat) -> String {
        DateFormatter.shared.dateFormat = format.description
        return DateFormatter.shared.string(from: self)
    }
    
    static func from(string: String, format: DateFormat) -> Date? {
        DateFormatter.shared.dateFormat = format.description
        return DateFormatter.shared.date(from: string)
    }
}

public enum DateFormat: CustomStringConvertible {
    case system
    case GMT
    case ISO8601
    case ISO8601_SSS
    case format(String)
    
    public var description: String {
        switch self {
        case .system: return "yyyy-MM-dd HH:mm:ss.SSSSSSZ" // 2025-12-09 18:39:41.911312+0800
        case .GMT: return "EEE MMM dd yyyy HH:mm:ss 'GMT'Z" // Sat Dec 06 2025 17:12:49 GMT+0800
        case .ISO8601: return "yyyy-MM-dd'T'HH:mm:ssZ" // 2025-12-06T17:17:03+0800
        case .ISO8601_SSS: return "yyyy-MM-dd'T'HH:mm:ss.SSSZ" // 2025-12-06T17:17:03.123+0800
        case .format(let string): return string
        }
    }
}

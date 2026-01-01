//
//  SystemLogger.swift
//  Mixed
//
//  Created by vvii on 2025/12/26.
//

import Foundation

public class SystemLogger: NSObject, LogProtocol {
    
    public func setup() {
        // do noting
    }
    
    public func flush() {
        // do noting
    }
    
    public func close() {
        // do noting
    }
    
    public func getLogFilePaths() -> [String] {
        // do noting
        return []
    }
    
    public func clearLogFiles() {
        // do noting
    }
    
    public func verbose(_ messages: Any ...,
                     file: StaticString = #file,
                     function: StaticString = #function,
                     line: UInt = #line,
                     tag: String? = nil) {
        print(messages, level: .verbose, file: file, function: function, line: line, tag: tag)
    }
    
    public func debug(_ messages: Any ...,
                     file: StaticString = #file,
                     function: StaticString = #function,
                     line: UInt = #line,
                     tag: String? = nil) {
        print(messages, level: .debug, file: file, function: function, line: line, tag: tag)
    }
    
    public func info(_ messages: Any ...,
                     file: StaticString = #file,
                     function: StaticString = #function,
                     line: UInt = #line,
                     tag: String? = nil) {
        print(messages, level: .info, file: file, function: function, line: line, tag: tag)
    }
    
    public func warn(_ messages: Any ...,
                     file: StaticString = #file,
                     function: StaticString = #function,
                     line: UInt = #line,
                     tag: String? = nil) {
        print(messages, level: .warn, file: file, function: function, line: line, tag: tag)
    }
    
    public func error(_ messages: Any ...,
                     file: StaticString = #file,
                     function: StaticString = #function,
                     line: UInt = #line,
                     tag: String? = nil) {
        print(messages, level: .error, file: file, function: function, line: line, tag: tag)
    }
}

extension SystemLogger {
    
    enum Level: String {
        case verbose    = "V"
        case debug      = "D"
        case info       = "I"
        case warn       = "W"
        case error      = "E"
    }
    
    static let flags: [SystemLogger.Level: String] = [
        .error:     "❌",
        .warn:      "⚠️",
        .info:      "✅",
        .debug:     "🟦",
        .verbose:   "🟪"
    ]
    
    private func print(_ messages: Any ...,
                level: Level,
                file: StaticString = #file,
                function: StaticString = #function,
                line: UInt = #line,
                tag: String? = nil) {
        let flag = "\(SystemLogger.flags[level] ?? "?")"
        let messages = messages.map({ String(describing: $0) }).joined(separator: ", ")
        let level = "[\(level.rawValue)]"
        let tag = "[\(tag ?? "?")]"
        let info = "[\(String(describing: file).split(separator: "/").last ?? "?"):\(line) \(function)]"
        let message = "\(flag) \(Date().formatted(.system)) \(level)\(tag)\(info):\n\(messages)"
        Swift.print(message)
    }
}

//
//  PulseLogger.swift
//  Anyswift
//
//  Created by vvii on 2025/12/26.
//

#if canImport(Pulse)
import Pulse

public class PulseLogger: NSObject, LogProtocol {
    
    var logger: LoggerStore?
    
    public func setup() {
        logger = LoggerStore.shared
    }
    
    public func flush() {
        
    }
    
    public func close() {
        
    }
    
    public func getLogFilePaths() -> [String] {
        return []
    }
    
    public func clearLogFiles() {
        
    }
    
    public func verbose(_ messages: Any ...,
                     file: StaticString = #file,
                     function: StaticString = #function,
                     line: UInt = #line,
                     tag: String? = nil) {
        log(messages, level: .trace, file: file, function: function, line: line, tag: tag)
    }
    
    public func debug(_ messages: Any ...,
                     file: StaticString = #file,
                     function: StaticString = #function,
                     line: UInt = #line,
                     tag: String? = nil) {
        log(messages, level: .debug, file: file, function: function, line: line, tag: tag)
    }
    
    public func info(_ messages: Any ...,
                     file: StaticString = #file,
                     function: StaticString = #function,
                     line: UInt = #line,
                     tag: String? = nil) {
        log(messages, level: .info, file: file, function: function, line: line, tag: tag)
    }
    
    public func warn(_ messages: Any ...,
                     file: StaticString = #file,
                     function: StaticString = #function,
                     line: UInt = #line,
                     tag: String? = nil) {
        log(messages, level: .warning, file: file, function: function, line: line, tag: tag)
    }
    
    public func error(_ messages: Any ...,
                     file: StaticString = #file,
                     function: StaticString = #function,
                     line: UInt = #line,
                     tag: String? = nil) {
        log(messages, level: .error, file: file, function: function, line: line, tag: tag)
    }
}

extension PulseLogger {
    
    enum Level: String {
        case verbose    = "V"
        case debug      = "D"
        case info       = "I"
        case warn       = "W"
        case error      = "E"
    }
    
    static let flags: [LoggerStore.Level: String] = [
        .error:     "❌",
        .warning:   "⚠️",
        .info:      "✅",
        .debug:     "🟦",
        .trace:     "🟪"
    ]
    
    private func log(_ messages: Any ...,
                level: LoggerStore.Level,
                file: StaticString = #file,
                function: StaticString = #function,
                line: UInt = #line,
                tag: String? = nil) {
        let messages = messages.map({ String(describing: $0) }).joined(separator: ", ")
        let flag = "\(PulseLogger.flags[level] ?? "?")"
        let tag = "[\(tag ?? "?")]"
        let info = "[\(String(describing: file).split(separator: "/").last ?? "?"):\(line) \(function)]"
        let message = "\(flag) \(Date().formatted(.system)) [\(level)]\(tag)\(info):\n\(messages)"
        logger?.storeMessage(label: tag, level: level, message: message)
        Swift.print(message)
    }
}
#endif



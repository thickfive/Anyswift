//
//  Log.swift
//  Mixed
//
//  Created by vvii on 2025/12/26.
//

import Foundation

@objc public class Log: NSObject {
    
    public class func verbose(_ messages: Any ...,
                     file: StaticString = #file,
                     function: StaticString = #function,
                     line: UInt = #line,
                     tag: String? = nil) {
        LogManager.shared.logger?.verbose(messages, file: file, function: function, line: line, tag: tag)
    }
    
    public class func debug(_ messages: Any ...,
                     file: StaticString = #file,
                     function: StaticString = #function,
                     line: UInt = #line,
                     tag: String? = nil) {
        LogManager.shared.logger?.debug(messages, file: file, function: function, line: line, tag: tag)
    }
    
    public class func info(_ messages: Any ...,
                     file: StaticString = #file,
                     function: StaticString = #function,
                     line: UInt = #line,
                     tag: String? = nil) {
        LogManager.shared.logger?.info(messages, file: file, function: function, line: line, tag: tag)
    }
    
    public class func warn(_ messages: Any ...,
                     file: StaticString = #file,
                     function: StaticString = #function,
                     line: UInt = #line,
                     tag: String? = nil) {
        LogManager.shared.logger?.warn(messages, file: file, function: function, line: line, tag: tag)
    }
    
    public class func error(_ messages: Any ...,
                     file: StaticString = #file,
                     function: StaticString = #function,
                     line: UInt = #line,
                     tag: String? = nil) {
        LogManager.shared.logger?.error(messages, file: file, function: function, line: line, tag: tag)
    }
    
    @objc public class func logMessage(_ message: String) {
        LogManager.shared.logger?.info(message, file: "", function: "", line: 0, tag: nil)
    }
}


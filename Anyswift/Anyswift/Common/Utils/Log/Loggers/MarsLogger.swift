//
//  MarsLogger.swift
//  Mixed
//
//  Created by vvii on 2025/12/26.
//

#if canImport(XXLog)
import XXLog

public class MarsLogger: NSObject, LogProtocol {
    
    public func setup() {
        let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first! + "/log"
        let config = XXLogConfig(
            path: path,
            level: XXLogLevel.all,
            isConsoleLog: true,
            pubKey: "<pubKey>",
            cacheDays: 5
        )
        XXLogHelper.shared().setupConfig(config)
    }
    
    public func flush() {
        XXLogHelper.logAppenderFlush()
    }
    
    public func close() {
        XXLogHelper.logAppenderClose()
    }
    
    public func getLogFilePaths() -> [String] {
        return (XXLogHelper.shared().getLogFilePathList() as? [String]) ?? []
    }
    
    public func clearLogFiles() {
        XXLogHelper.shared().clearLocalLogFile()
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
        print(messages, level: .warn, file: file, function: function, line: line, tag: tag)
    }
}

extension MarsLogger {
    
    private func print(_ messages: Any ...,
                level: XXLogLevel,
                file: StaticString = #file,
                function: StaticString = #function,
                line: UInt = #line,
                tag: String? = nil) {
        // [level][tag][file:line function] message
        let file = String(describing: file).split(separator: "/").last ?? "?"
        XXLog.print(level: level, tag: tag ?? "?", fileName: "\(file)", line: line, funcName: "\(function)", items: messages)
    }
}
#endif


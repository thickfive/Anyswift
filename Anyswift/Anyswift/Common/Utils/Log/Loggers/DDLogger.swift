//
//  DDLogger.swift
//  Mixed
//
//  Created by vvii on 2025/12/26.
//

#if canImport(CocoaLumberjackSwift)
import CocoaLumberjackSwift

public class DDLogger: NSObject, LogProtocol {
    
    var fileLogger: DDFileLogger?
    
    public func setup() {
        let ttyLogger = DDTTYLogger.sharedInstance!
        ttyLogger.logFormatter = self
        DDLog.add(ttyLogger, with: .all)
        
        let fileLogger = DDFileLogger()
        fileLogger.rollingFrequency = 60 * 60 * 24 // 60 * 60 * 24 (秒)
        fileLogger.logFileManager.maximumNumberOfLogFiles = 5
        fileLogger.logFormatter = self
        DDLog.add(fileLogger, with: .all)
        self.fileLogger = fileLogger
        
        print(fileLogger.logFileManager.logsDirectory, fileLogger.logFileManager.sortedLogFilePaths)
    }
    
    public func flush() {
        DDLog.flushLog()
    }
    
    public func close() {
        DDLog.removeAllLoggers()
    }
    
    public func getLogFilePaths() -> [String] {
        return fileLogger?.logFileManager.sortedLogFilePaths ?? []
    }
    
    public func clearLogFiles() {
        do {
            if let logFileManager = fileLogger?.logFileManager, logFileManager.responds(to: #selector(DDLogFileManager.cleanupLogFiles)) {
                // optional func cleanupLogFiles() throws
                // 这里不能用 ?, 编译无法通过, 只能用 !
                //
                // try logFileManager.cleanupLogFiles!()
                //
                // 实际上文件只有满足条件才会被删除, 需要手动删除
                for info in logFileManager.unsortedLogFileInfos {
                    if info.isArchived {
                        try FileManager.default.removeItem(atPath: info.filePath)
                    }
                }
            }
        } catch {
            Log.error(error)
        }
    }
    
    public func verbose(_ messages: Any ...,
                     file: StaticString = #file,
                     function: StaticString = #function,
                     line: UInt = #line,
                     tag: String? = nil) {
        let message = messages.map({ String(describing: $0) }).joined(separator: ", ")
        DDLogVerbose("\(message)", file: file, function: function, line: line, tag: tag)
    }
    
    public func debug(_ messages: Any ...,
                     file: StaticString = #file,
                     function: StaticString = #function,
                     line: UInt = #line,
                     tag: String? = nil) {
        let message = messages.map({ String(describing: $0) }).joined(separator: ", ")
        DDLogDebug("\(message)", file: file, function: function, line: line, tag: tag)
    }
    
    public func info(_ messages: Any ...,
                     file: StaticString = #file,
                     function: StaticString = #function,
                     line: UInt = #line,
                     tag: String? = nil) {
        let message = messages.map({ String(describing: $0) }).joined(separator: ", ")
        DDLogInfo("\(message)", file: file, function: function, line: line, tag: tag)
    }
    
    public func warn(_ messages: Any ...,
                     file: StaticString = #file,
                     function: StaticString = #function,
                     line: UInt = #line,
                     tag: String? = nil) {
        let message = messages.map({ String(describing: $0) }).joined(separator: ", ")
        DDLogWarn("\(message)", file: file, function: function, line: line, tag: tag)
    }
    
    public func error(_ messages: Any ...,
                     file: StaticString = #file,
                     function: StaticString = #function,
                     line: UInt = #line,
                     tag: String? = nil) {
        let message = messages.map({ String(describing: $0) }).joined(separator: ", ")
        DDLogError("\(message)", file: file, function: function, line: line, tag: tag)
    }
}

extension DDLogger: DDLogFormatter {
    
    static let levels: [UInt: String] = [
        DDLogFlag.error.rawValue:     "E",
        DDLogFlag.warning.rawValue:   "W",
        DDLogFlag.info.rawValue:      "I",
        DDLogFlag.debug.rawValue:     "D",
        DDLogFlag.verbose.rawValue:   "V"
    ]
    
    static let flags: [UInt: String] = [
        DDLogFlag.error.rawValue:     "❌",
        DDLogFlag.warning.rawValue:   "⚠️",
        DDLogFlag.info.rawValue:      "✅",
        DDLogFlag.debug.rawValue:     "🟦",
        DDLogFlag.verbose.rawValue:   "🟪"
    ]
    
    public func format(message logMessage: DDLogMessage) -> String? {
        // [level][tag][file:line function] message
        let flag = "\(DDLogger.flags[logMessage.flag.rawValue] ?? "?")"
        let level = "[\(DDLogger.levels[logMessage.flag.rawValue] ?? "?")]"
        let tag = "[\(logMessage.representedObject ?? "?")]"
        let info = "[\(logMessage.file.split(separator: "/").last ?? "?"):\(logMessage.line) \(logMessage.function ?? "?")]"
        let message = "\(flag) \(Date().formatted(.system)) \(level)\(tag)\(info):\n\(logMessage.message)"
        return message
    }
}
#endif


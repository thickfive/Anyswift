//
//  LogManager.swift
//  Mixing
//
//  Created by vvii on 2025/12/26.
//

import Foundation

public class LogManager: NSObject {
    
    public static let shared = LogManager()
    
    var logger: LogProtocol?
    
    public func setup(logger: LogProtocol?) {
        self.logger = logger
        self.logger?.setup()
    }
    
    public func flush() {
        logger?.flush()
    }
    
    public func close() {
        logger?.close()
    }
    
    public func getLogFilePaths() -> [String] {
        return logger?.getLogFilePaths() ?? []
    }
    
    public func clearLogFiles() {
        logger?.clearLogFiles()
    }
}

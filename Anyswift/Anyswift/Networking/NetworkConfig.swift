//
//  NetworkConfig.swift
//  Anyswift
//
//  Created by vvii on 2025/12/26.
//

import Foundation

public struct NetworkConfig {
    public let baseURL: String
    public let headers: [String: String]
}

public let networkConfig = NetworkConfig(
    baseURL: "http://192.168.1.101:8000",
    headers: [:]
)


//
//  Response.swift
//  Anyswift
//
//  Created by vvii on 2025/12/26.
//

import Foundation

public struct AnyResponse<DataType: Codable>: Codable {
    public let code: Int
    public let message: String
    public let data: DataType?
}

/// Null supports any valid JSON, including null.
///
/// json = { "code": 200, "message": "OK", "data": <data> }
/// 1. If <data> is null or the field does not exist, the data value is nil.
/// 2. If <data> is another valid JSON fragment, the data value is Null().
public struct Null: Codable {
    // no property
}



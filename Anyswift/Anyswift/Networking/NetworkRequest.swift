//
//  TargetType.swift
//  Anyswift
//
//  Created by vvii on 2025/12/26.
//

import Foundation
import Moya
import Alamofire

public protocol AnyRequest: TargetType {}

public extension AnyRequest {
    var baseURL: URL {
        return URL(string: NetworkManager.shared.config.baseURL)!
    }
    
    var path: String {
        return ""
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return NetworkManager.shared.config.headers
    }
}

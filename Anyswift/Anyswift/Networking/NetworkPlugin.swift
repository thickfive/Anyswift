//
//  NetworkPlugin.swift
//  Anyswift
//
//  Created by vvii on 2025/12/26.
//

import Foundation
import Moya
import Alamofire

public struct NetworkPlugin: PluginType {
    /// Called to modify a request before sending.
    public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        return request
    }

    /// Called immediately before a request is sent over the network (or stubbed).
    public func willSend(_ request: RequestType, target: TargetType) {
        Log.debug()
    }

    /// Called after a response has been received, but before the MoyaProvider has invoked its completion handler.
    public func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
        Log.debug()
    }

    /// Called to modify a result before completion.
    public func process(_ result: Result<Moya.Response, MoyaError>, target: TargetType) -> Result<Moya.Response, MoyaError> {
        return result
    }
}

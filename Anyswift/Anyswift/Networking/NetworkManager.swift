//
//  NetworkManager.swift
//  Anyswift
//
//  Created by vvii on 2025/12/26.
//

import Foundation
import Moya
import Alamofire

/// fix _Concurrency.Task conflicts with Moya.Task
public typealias Task = _Concurrency.Task

public class NetworkManager {
    public static let shared = NetworkManager()
    private(set) var config: NetworkConfig!
    
    public func setup(config: NetworkConfig) {
        self.config = config
    }
    
    private lazy var session: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 15
        configuration.timeoutIntervalForResource = 60
        let session = Session.init(configuration: configuration)
        return session
    }()
    
    public func makeProvider<TargetType>() -> MoyaProvider<TargetType> {
        MoyaProvider<TargetType>.init(
            session: session,
            plugins: [] // [NetworkPlugin(), NetworkLoggerPlugin()]
        )
    }
    
    /// request
    /// - Parameters:
    ///   - target: TargetType
    ///   - provider: MoyaProvider<TargetType>
    /// - Returns: AnyResponse<DataType>
    public func request<TargetType, DataType>(target: TargetType, provider: MoyaProvider<TargetType>) async throws -> AnyResponse<DataType> {
        try await withCheckedThrowingContinuation { continuation in
            provider.request(target) { result in
                switch result {
                case let .success(moyaResponse):
                    let statusCode = moyaResponse.statusCode
                    if statusCode == 200 {
                        do {
                            let decoder = JSONDecoder()
                            let response = try decoder.decode(AnyResponse<DataType>.self, from: moyaResponse.data)
                            self.logSuccess(response: moyaResponse)
                            continuation.resume(returning: response)
                        } catch {
                            self.logFailure(response: moyaResponse, error: error)
                            continuation.resume(throwing: error)
                        }
                    } else {
                        self.logFailure(response: moyaResponse, statusCode: statusCode)
                        continuation.resume(throwing: MoyaError.statusCode(moyaResponse))
                    }
                case let .failure(error):
                    // this means there was a network failure - either the request
                    // wasn't sent (connectivity), or no response was received (server
                    // timed out).  If the server responds with a 4xx or 5xx error, that
                    // will be sent as a ".success"-ful response.
                    self.logFailure(error: error)
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
}

/// Log
extension NetworkManager {
    func message(for response: Moya.Response) -> String {
        if let request = response.request {
            var message = ""
            message += request.httpMethod ?? "<nil>"
            message += " "
            message += request.url?.absoluteString ?? "<nil>"
            message += " "
            message += "\(response.statusCode)"
            message += "\n"
            message += response.request?.httpBody?.jsonString ?? "<nil>"
            message += "\n"
            message += response.data.jsonString ?? "<nil>"
            return message
        }
        return "<nil>"
    }
    
    func logSuccess(response: Moya.Response) {
        Log.info("===== request successful =====\n" + message(for: response))
    }
    
    func logFailure(response: Moya.Response, statusCode: Int) {
        Log.error("===== request error: statusCode = \(statusCode) =====\n" + message(for: response))
    }
    
    func logFailure(response: Moya.Response, error: Error) {
        Log.error("===== request error: \(error) =====\n" + message(for: response))
    }
    
    func logFailure(error: MoyaError) {
        Log.error("===== request failed: \(error) =====")
    }
}

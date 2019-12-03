//
//  DefaultNetworkService.swift
//  Carfie
//
//  Created by Christopher Olsen on 10/20/19.
//  Copyright © 2019 Christopher Olsen. All rights reserved.
//

import Foundation

public class DefaultNetworkService: NetworkService {
    
    private var task: URLSessionTask?
    
    private let configuration: ServiceConfiguration
    
    public init(configuration: ServiceConfiguration) {
        self.configuration = configuration
    }
    
    public func request<T: NetworkRequest>(_ request: T, completion: @escaping (Result<T.Response>) -> Void) {
        let session = URLSession.shared
        do {
            let request = try buildRequest(from: request)
            task = session.dataTask(with: request) { (data, response, error) in
                guard error == nil else {
                    DispatchQueue.main.async {
                        completion(.failure(error!))
                    }
                    return
                }
                
                do {
                    guard let data = data else { return }
                    let response: T.Response = try JSONResponseDecoder.decode(data: data)
                    DispatchQueue.main.async {
                        completion(.success(response))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            }
        } catch {
            DispatchQueue.main.async {
                completion(.failure(error))
            }
        }
        
        task?.resume()
    }
    
    public func cancel() {
        task?.cancel()
    }
    
    private func buildRequest<T: NetworkRequest>(from request: T) throws -> URLRequest {
        var urlRequest = URLRequest(url: configuration.baseUrl.appendingPathComponent(request.path),
                                 cachePolicy: .useProtocolCachePolicy,
                                 timeoutInterval: 10.0)
        urlRequest.httpMethod = request.method.rawValue
        
        addHeaders(request.headers, request: &urlRequest)
        configureBody(request.body, request: &urlRequest)
        
        do {
            try configureParameters(configuration.defaultParameters, request: &urlRequest)
            try configureParameters(request.parameters, request: &urlRequest)
            return urlRequest
        } catch {
            throw error
        }
    }
    
    private func addHeaders(_ headers: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = headers else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    
    private func configureParameters(_ parameters: Parameters?, request: inout URLRequest) throws {
        guard let parameters = parameters else { return }
        
        do {
            try URLParameterEncoder.encode(request: &request, with: parameters)
        } catch {
            throw error
        }
    }
    
    private func configureBody(_ body: Data?, request: inout URLRequest) {
        guard let body = body else { return }
        request.httpBody = body
    }
}

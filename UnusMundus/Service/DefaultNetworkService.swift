//
//  DefaultNetworkService.swift
//  UnusMundus
//
//  Created by Christopher Olsen on 10/20/19.
//  Copyright © 2019 Christopher Olsen. All rights reserved.
//

import Foundation

public class DefaultNetworkService: NetworkService {
    
    private var task: URLSessionTask?
    
    private let configuration: ServiceConfiguration
    private let session: NetworkSession
    
    public init(configuration: ServiceConfiguration, session: NetworkSession = URLSession.shared) {
        self.configuration = configuration
        self.session = session
    }
    
    public func request<T: NetworkRequest>(_ request: T, completion: @escaping (Result<T.Response>) -> Void) {
        let request = buildRequest(from: request)
        task = session.dataTask(with: request) { (data, _, error) in
            guard error == nil else {
                DispatchQueue.main.async {
                    completion(.failure(error!))
                }
                return
            }
            
            do {
                guard let data = data else { return }
                let response: T.Response = try JSONResponseDecoder().decode(from: data)
                DispatchQueue.main.async {
                    completion(.success(response))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
        
        task?.resume()
    }
    
    public func cancel() {
        task?.cancel()
    }
    
    private func buildRequest<T: NetworkRequest>(from request: T) -> URLRequest {
        var urlRequest = URLRequest(url: configuration.baseUrl.appendingPathComponent(request.path),
                                    cachePolicy: .useProtocolCachePolicy,
                                    timeoutInterval: 10.0)
        urlRequest.httpMethod = request.method.rawValue
        
        // add default values
        addHeaders(configuration.defaultHeaders, request: &urlRequest)
        configureParameters(configuration.defaultParameters, request: &urlRequest)
        
        // add values from the request
        addHeaders(request.headers, request: &urlRequest)
        configureBody(request.body, request: &urlRequest)
        configureParameters(request.parameters, request: &urlRequest)
        
        return urlRequest
    }
    
    private func addHeaders(_ headers: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = headers else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    
    private func configureParameters(_ parameters: Parameters?, request: inout URLRequest) {
        guard let parameters = parameters else { return }
        URLParameterEncoder().encode(request: &request, with: parameters)
    }
    
    private func configureBody(_ body: Data?, request: inout URLRequest) {
        guard let body = body else { return }
        request.httpBody = body
    }
}

//
//  URLParameterEncoding.swift
//  UnusMundus
//
//  Created by Christopher Olsen on 10/20/19.
//  Copyright © 2019 Christopher Olsen. All rights reserved.
//

import Foundation

class URLParameterEncoder: ParameterEncoder {
    
    func encode(request: inout URLRequest, with parameters: Parameters) {
        guard let url = request.url else {
            assertionFailure("A URLRequest should always have a URL")
            return
        }
        
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
            urlComponents.queryItems = [URLQueryItem]()

            // check that parameters contain only characters allowed in URLs
            // add to urlComponents
            parameters.forEach {
                let value = "\($0.value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
                let queryItem = URLQueryItem(name: $0.key, value: value)
                urlComponents.queryItems?.append(queryItem)
            }
            
            request.url = urlComponents.url
        }
    }
}

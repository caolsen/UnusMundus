//
//  NetworkSession.swift
//  UnusMundus
//
//  Created by Christopher Olsen on 12/5/19.
//  Copyright © 2019 Christopher Olsen. All rights reserved.
//

import Foundation

/// This exists for mocking purposes. URLSession conforms to this protocol.
public protocol NetworkSession {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: NetworkSession {}

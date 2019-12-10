//
//  MockNetworkRequest.swift
//  UnusMundusTests
//
//  Created by Christopher Olsen on 12/9/19.
//  Copyright © 2019 Christopher Olsen. All rights reserved.
//

@testable import UnusMundus

struct MockNetworkRequest: NetworkRequest {
    typealias Response = MockDecodableObject
    
    let method: HTTPMethod = .GET
    let path = "/getMockRequest"
}

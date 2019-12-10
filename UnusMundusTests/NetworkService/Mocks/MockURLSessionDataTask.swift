//
//  URLSessionDataTaskMock.swift
//  UnusMundusTests
//
//  Created by Christopher Olsen on 12/5/19.
//  Copyright © 2019 Christopher Olsen. All rights reserved.
//

import Foundation

class MockURLSessionDataTask: URLSessionDataTask {
    private let completion: () -> Void
    
    init(completion: @escaping () -> Void) {
        self.completion = completion
    }
    
    override func resume() {
        completion()
    }
}

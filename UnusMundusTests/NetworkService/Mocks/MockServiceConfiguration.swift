//
//  MockServiceConfiguration.swift
//  UnusMundusTests
//
//  Created by Christopher Olsen on 12/6/19.
//  Copyright © 2019 Christopher Olsen. All rights reserved.
//

@testable import UnusMundus

struct MockServiceConfiguration: ServiceConfiguration {
    var baseUrl: URL {
        return URL(string: "https://umn.com")!
    }
}

//
//  ServiceConfiguration.swift
//  CoreTests
//
//  Created by Christopher Olsen on 11/18/19.
//  Copyright © 2019 Christopher Olsen. All rights reserved.
//

import Foundation

/// Specifies configuration options for a given endpoint.
public protocol ServiceConfiguration {
    
    /// The base URL used for all requests. Individual request paths will be appended to this URL.
    /// Trailing slashes are not necessary.
    var baseUrl: URL { get }
    
    /// Default parameters included in all requests. This can be used to insert api keys, etc.
    var defaultParameters: Parameters? { get }
}

// Extension for default values.
public extension ServiceConfiguration {
    var defaultParameters: Parameters? {
        return nil
    }
}

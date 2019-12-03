//
//  Result.swift
//  UnusMundus
//
//  Created by Christopher Olsen on 12/2/19.
//  Copyright © 2019 Christopher Olsen. All rights reserved.
//

import Foundation

public enum Result<T> {
    case success(T)
    case failure(Error)
}

extension Result {

    public func resolve() throws -> T {
        switch self {
        case .success(let value): return value
        case .failure(let error): throw error
        }
    }
}

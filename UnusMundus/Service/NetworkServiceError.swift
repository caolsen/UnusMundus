//
//  NetworkServiceError.swift
//  Carfie
//
//  Created by Christopher Olsen on 10/20/19.
//  Copyright © 2019 Christopher Olsen. All rights reserved.
//

import Foundation

public enum NetworkServiceError: Error {
    case encodingFailed
    case decodingFailed
    case missingURL
    case missingData
}

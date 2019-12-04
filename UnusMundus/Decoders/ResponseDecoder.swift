//
//  ResponseDecoder.swift
//  Carfie
//
//  Created by Christopher Olsen on 10/20/19.
//  Copyright © 2019 Christopher Olsen. All rights reserved.
//

import Foundation

public protocol ResponseDecoder {
    func decode<T: Decodable>(from data: Data) throws -> T
}

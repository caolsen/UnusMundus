//
//  JSONParser.swift
//  Carfie
//
//  Created by Christopher Olsen on 10/20/19.
//  Copyright © 2019 Christopher Olsen. All rights reserved.
//

import Foundation

/// Decode data into an object of Type T that conforms to Decodable.
public class JSONResponseDecoder: ResponseDecoder {
    
    public static func decode<T: Decodable>(data: Data) throws -> T {
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkServiceError.decodingFailed
        }
    }
}

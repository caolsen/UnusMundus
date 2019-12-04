//
//  ParameterEncoder.swift
//  Carfie
//
//  Created by Christopher Olsen on 10/20/19.
//  Copyright © 2019 Christopher Olsen. All rights reserved.
//

import Foundation

protocol ParameterEncoder {
    func encode(request: inout URLRequest, with parameters: Parameters)
}

//
//  WeightRange.swift
//
//
//  Created by Bhavin Bhadani on 21/03/24.
//

import Foundation

public struct WeightRange: Codable {
    public let min: Int
    public let max: Int
    
    public init(min: Int, max: Int) {
        self.min = min
        self.max = max
    }
}

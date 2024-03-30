//
//  Offer.swift
//
//
//  Created by Bhavin Bhadani on 21/03/24.
//

import Foundation

public struct Offer: Codable {
    public let discount: Int
    public let distanceRange: DistanceRange
    public let weightRange: WeightRange
    
    public init(discount: Int, distanceRange: DistanceRange, weightRange: WeightRange) {
        self.discount = discount
        self.distanceRange = distanceRange
        self.weightRange = weightRange
    }
}

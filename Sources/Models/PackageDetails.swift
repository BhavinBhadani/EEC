//
//  PackageDetails.swift
//
//
//  Created by Bhavin Bhadani on 21/03/24.
//

import Foundation

public struct PackageDetails {
    public let packageId: String
    public let weight: Int
    public let distance: Int
    public let offerCode: String
    public let index: Int
    
    public init(packageId: String, weight: Int, distance: Int, offerCode: String, index: Int) {
        self.packageId = packageId
        self.weight = weight
        self.distance = distance
        self.offerCode = offerCode
        self.index = index
    }
}

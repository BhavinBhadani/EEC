//
//  PackageDetails.swift
//
//
//  Created by Bhavin Bhadani on 21/03/24.
//

import Foundation

public struct Package {
    public let basePrice: Int
    public let packageId: String
    public let weight: Int
    public let distance: Int
    public let offerCode: String?
    
    public init(packageId: String, basePrice: Int, weight: Int, distance: Int, offerCode: String?) {
        self.packageId = packageId
        self.basePrice = basePrice
        self.weight = weight
        self.distance = distance
        self.offerCode = offerCode
    }
}

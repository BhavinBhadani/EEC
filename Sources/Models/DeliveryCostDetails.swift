//
//  DeliveryCostDetails.swift
//
//
//  Created by Bhavin Bhadani on 21/03/24.
//

import Foundation

public struct DeliveryCostDetails {
    public let packageId: String
    public let packageWeight: Int
    public let distance: Int
    public let offerCode: String
    
    public init(packageId: String, packageWeight: Int, distance: Int, offerCode: String) {
        self.packageId = packageId
        self.packageWeight = packageWeight
        self.distance = distance
        self.offerCode = offerCode
    }
}

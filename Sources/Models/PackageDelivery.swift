//
//  PackageDelivery.swift
//  
//
//  Created by Bhavin Bhadani on 21/03/24.
//

import Foundation

public struct PackageDelivery {
    public let packageId: String
    public let discount: Int?
    public let deliveryCost: Int?
    public let duration: Double?
    
    public init(packageId: String, discount: Int?, deliveryCost: Int?, duration: Double?) {
        self.packageId = packageId
        self.discount = discount
        self.deliveryCost = deliveryCost
        self.duration = duration
    }
}

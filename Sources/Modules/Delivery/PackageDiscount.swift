//
//  File.swift
//
//
//  Created by Bhavin Bhadani on 03/04/24.
//

import Foundation
import Models
import Utils

public struct PackageDiscount {
    public let packageId: String
    public let packageWeight: Int
    public let distance: Int
    public let offerCode: String?
    public let basePrice: Int
    public let costOfUnitDistance: Int
    public let costOfUnitWeight: Int
    
    public init(packageId: String, packageWeight: Int, distance: Int, offerCode: String? = nil, basePrice: Int, costOfUnitDistance: Int = 5, costOfUnitWeight: Int = 10) {
        self.packageId = packageId
        self.packageWeight = packageWeight
        self.distance = distance
        self.offerCode = offerCode
        self.basePrice = basePrice
        self.costOfUnitDistance = costOfUnitDistance
        self.costOfUnitWeight = costOfUnitWeight
    }
    
    public func calculateDiscount() -> (price: Int, discount: Int, packageId: String)? {
        guard !packageId.isEmpty, packageWeight > 0, distance > 0 else {
            return nil
        }
        
        if let offer = isOfferApplicable() {
            let price = basePrice + packageWeight * costOfUnitWeight + distance * costOfUnitDistance
            let discount = (Double(offer.discount) / 100.0) * Double(price)
            return (price - Int(discount), Int(discount), packageId)
        }
        
        let price = basePrice + packageWeight * costOfUnitWeight + distance * costOfUnitDistance
        return (price, 0, packageId)
    }
    
    public func isOfferApplicable() -> Offer? {
        let offerCode = offerCode?.uppercased()
        let offerCodes = GetOffers.readOfferCodesFromFile() ?? [:]
        if let offerCode = offerCode,
            let offer = offerCodes[offerCode],
           (isBetween(distance, offer.distanceRange.min, offer.distanceRange.max) &&
            isBetween(packageWeight, offer.weightRange.min, offer.weightRange.max)) {
            return offer
        }
        return nil
    }
}

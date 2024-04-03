//
//  NewOffer.swift
//
//
//  Created by Bhavin Bhadani on 03/04/24.
//

import Foundation
import Models
import Utils

public struct NewOffer {
    public let offerId: String
    public let discount: Int
    public let minWeight: Int
    public let maxWeight: Int
    public let minDistance: Int
    public let maxDistance: Int
    
    public init(offerId: String, discount: Int, minWeight: Int, maxWeight: Int, minDistance: Int, maxDistance: Int) {
        self.offerId = offerId
        self.discount = discount
        self.minWeight = minWeight
        self.maxWeight = maxWeight
        self.minDistance = minDistance
        self.maxDistance = maxDistance
    }
    
    public func insert() throws -> String {
        if offerId.isEmpty {
            throw AddOfferError.invalidCode("Error: Offer ID cannot be empty".red)
        }
        
        if minDistance >= maxDistance {
            throw AddOfferError.invalidRange("Error: Invalid distance range".red)
        }

        if minWeight >= maxWeight {
            throw AddOfferError.invalidRange("Error: Invalid weight range".red)
        }

        let newOffer = Offer(
            discount: discount,
            distanceRange: DistanceRange(min: minDistance, max: maxDistance),
            weightRange: WeightRange(min: minWeight, max: maxWeight)
        )

        let bundle = Bundle.module
        guard let fileURL = bundle.url(forResource: "Resources/offers", withExtension: "json") else {
            throw AddOfferError.fileNotFount("Error: Unable to locate offers.json".red)
        }
        
        var offers: [String: Offer]
        if let data = try? Data(contentsOf: fileURL),
           let decodedOfferCodes = try? JSONDecoder().decode([String: Offer].self, from: data) {
            offers = decodedOfferCodes
        } else {
            offers = [:]
        }
        
        offers[offerId.uppercased()] = newOffer
        
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let encodedData = try encoder.encode(offers)
            try encodedData.write(to: fileURL)
            return "---- Offer added successfully ----".purple
        } catch {
            throw AddOfferError.unableToWrite("---- Error: \(error.localizedDescription) ----".red)
        }
    }
}

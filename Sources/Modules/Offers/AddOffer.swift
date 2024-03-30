//
//  AddOffer.swift
//  
//
//  Created by Bhavin Bhadani on 21/03/24.
//

import Foundation
import Models

public enum AddOffer {
    
    public static func getNewOfferDetails() {
        do {
            let offerDetails = try OfferInputs.askToAddOffer()
            
            let addedMessage = addNewOfferCode(
                offerId: offerDetails.offerId,
                discount: offerDetails.discount,
                minWeight: offerDetails.minWeight,
                maxWeight: offerDetails.maxWeight,
                minDistance: offerDetails.minDistance,
                maxDistance: offerDetails.maxDistance
            )
            print(addedMessage)
        } catch {
            print("Error: \(error)")
        }
    }

    public static func addNewOfferCode(offerId: String, discount: Int, minWeight: Int, maxWeight: Int, minDistance: Int, maxDistance: Int) -> String {
        let newOffer = Offer(
            discount: discount,
            distanceRange: DistanceRange(min: minDistance, max: maxDistance),
            weightRange: WeightRange(min: minWeight, max: maxWeight)
        )
        
        let bundle = Bundle.module
        guard let fileURL = bundle.url(forResource: "offers", withExtension: "json") else {
            return "Error: Unable to locate offers.json".red
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
            return "---- Error: \(error.localizedDescription) ----".red
        }
    }

}

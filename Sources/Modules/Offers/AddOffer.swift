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
            
            let offer = NewOffer(
                offerId: offerDetails.offerId,
                discount: offerDetails.discount,
                minWeight: offerDetails.minWeight,
                maxWeight: offerDetails.maxWeight,
                minDistance: offerDetails.minDistance,
                maxDistance: offerDetails.maxDistance
            )
            
            let addOffer = try offer.insert()
            print(addOffer)
        } catch {
            print("Error: \(error)")
        }
    }

}

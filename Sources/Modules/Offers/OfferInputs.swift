//
//  OfferInputs.swift
//
//
//  Created by Bhavin Bhadani on 21/03/24.
//

import Foundation

struct OfferInputs {
    
    static func askToAddOffer() throws -> (offerId: String, discount: Int, minWeight: Int, maxWeight: Int, minDistance: Int, maxDistance: Int) {
        print("Enter offer ID:".green)
        guard let offerId = readLine(), !offerId.isEmpty else {
            fatalError("Offer ID cannot be empty".red)
        }
        
        print("Enter discount:".green)
        guard let discountStr = readLine(), let discount = Int(discountStr) else {
            fatalError("Invalid discount value".red)
        }
        
        print("Enter minimum weight:".green)
        guard let minWeightStr = readLine(), let minWeight = Int(minWeightStr) else {
            fatalError("Invalid minimum weight value".red)
        }
        
        print("Enter maximum weight:".green)
        guard let maxWeightStr = readLine(), let maxWeight = Int(maxWeightStr) else {
            fatalError("Invalid maximum weight value".red)
        }
        
        print("Enter minimum distance:".green)
        guard let minDistanceStr = readLine(), let minDistance = Int(minDistanceStr) else {
            fatalError("Invalid minimum distance value".red)
        }
        
        print("Enter maximum distance:".green)
        guard let maxDistanceStr = readLine(), let maxDistance = Int(maxDistanceStr) else {
            fatalError("Invalid maximum distance value".red)
        }

        return (offerId, discount, minWeight, maxWeight, minDistance, maxDistance)
    }

}

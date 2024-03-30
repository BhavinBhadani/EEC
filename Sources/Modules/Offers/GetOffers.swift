//
//  GetOffers.swift
//
//
//  Created by Bhavin Bhadani on 21/03/24.
//

import Foundation
import Models
import Utils

public enum GetOffers {
    
    public static func readOfferCodesFromFile() -> [String: Offer]? {
        let bundle = Bundle.module
        guard let fileURL = bundle.url(forResource: "Resources/offers", withExtension: "json") else {
            print("Error: Unable to locate offers.json")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let offers = try decoder.decode([String: Offer].self, from: data)
            return offers
        } catch {
            print("Error decoding offers.json: \(error)")
            return nil
        }
    }
    
    public static func allOfferCodes() {
        guard let offers = readOfferCodesFromFile() else {
            return
        }
        
        var tableOutput = [
            ["Offer Id", "Discount", "Minimum Weight", "Maximum Weight", "Minimum Distance", "Minimum Distance"]
        ]

        for (offerId, offer) in offers.sorted(by: { $0.key < $1.key }) {
            tableOutput.append([offerId, "\(offer.discount)", "\(offer.weightRange.min)", "\(offer.weightRange.max)", "\(offer.distanceRange.min)", "\(offer.distanceRange.max)"])
        }
        
        Utility.printTable(from: tableOutput)
    }

}

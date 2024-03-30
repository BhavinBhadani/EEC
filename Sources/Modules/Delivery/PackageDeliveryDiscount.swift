//
//  PackageDeliveryDiscount.swift
//
//
//  Created by Bhavin Bhadani on 22/03/24.
//

import Foundation

struct PackageDeliveryDiscount {
    
    static func getDeliveryPriceDiscount() {
        do {
            let packageInfo = try DeliveryInputs.askBasicNumbersForPackages()
            
            var tableOutput = [
                ["Package Id", "Package Discount", "Package Price"],
            ]
            
            for index in 0..<packageInfo.packages {
                print("Enter details of package \(index + 1)")
                
                let deliveryCostDetails = try DeliveryInputs.askQuestionsForDeliveryCost()
                
                if let pkgPriceDiscount = getPackagePriceDiscount(packageId: deliveryCostDetails.packageId, packageWeight: deliveryCostDetails.packageWeight, distance: deliveryCostDetails.distance, offerCode: deliveryCostDetails.offerCode, basePrice: packageInfo.basePrice){
                    tableOutput.append([pkgPriceDiscount.pkgId, "\(pkgPriceDiscount.discount)", "\(pkgPriceDiscount.price)"])
                }
            }
            
            print("calculated discount and price".purple)
            Utility.printTable(from: tableOutput)
        } catch {
            print("Error: \(error)")
        }
    }

    static func getPackagePriceDiscount(packageId: String, packageWeight: Int, distance: Int, offerCode: String?, basePrice: Int, costOfUnitDistance: Int = 5, costOfUnitWeight: Int = 10) -> (price: Int, discount: Int, pkgId: String)? {
        let weight = packageWeight
        let basePrice = basePrice
        let distance = distance
        let offerCode = offerCode?.uppercased()
        
        guard !packageId.isEmpty, weight > 0, distance > 0, costOfUnitDistance > 0, costOfUnitWeight > 0 else {
            return nil
        }
        
        let offerCodes = GetOffers.readOfferCodesFromFile() ?? [:]
        if let offerCode = offerCode, let offer = offerCodes[offerCode] {
            if isBetween(distance, offer.distanceRange.min, offer.distanceRange.max) &&
                isBetween(weight, offer.weightRange.min, offer.weightRange.max) {
                let price = basePrice + weight * costOfUnitWeight + distance * costOfUnitDistance
                let discount = (Double(offer.discount) / 100.0) * Double(price)
                return (price - Int(discount), Int(discount), packageId)
            }
        }
        
        let price = basePrice + weight * costOfUnitWeight + distance * costOfUnitDistance
        return (price, 0, packageId)
    }

}

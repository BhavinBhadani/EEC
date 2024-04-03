//
//  PackageDeliveryDiscount.swift
//
//
//  Created by Bhavin Bhadani on 22/03/24.
//

import Foundation
import Utils

public struct PackageDeliveryDiscount {
    
    public static func getDeliveryPriceDiscount() {
        do {
            let packages = try PackageList.getPackageDetails()
            
            var tableOutput = [
                ["Package Id", "Package Discount", "Package Price"],
            ]

            for package in packages {
                let packageDiscount = PackageDiscount(packageId: package.packageId,
                                                      packageWeight: package.weight,
                                                      distance: package.distance,
                                                      offerCode: package.offerCode,
                                                      basePrice: package.basePrice)
                
                if let discountedPackage = packageDiscount.calculateDiscount() {
                    tableOutput.append(
                        [discountedPackage.packageId, "\(discountedPackage.discount)", "\(discountedPackage.price)"]
                    )
                }
            }
            
            print("calculated discount and price".purple)
            Utility.printTable(from: tableOutput)
        } catch {
            print("Error: \(error)")
        }
    }
}

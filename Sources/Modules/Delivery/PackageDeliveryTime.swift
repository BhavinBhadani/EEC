//
//  PackageDeliveryTime.swift
//
//
//  Created by Bhavin Bhadani on 22/03/24.
//

import Foundation
import Models
import Utils

public struct PackageDeliveryTime {
    
    public static func getAllPackageDeliveryTime() {
        do {
            let packages = try PackageList.getPackageDetails()
            let vehicleDetails = try DeliveryInputs.askVehicleDetails()
            
            let packageDelivery = PackageDeliveryEstimate(
                numberOfVehicles: vehicleDetails.totalVehicles,
                maxSpeed: vehicleDetails.maxSpeed,
                maxWeight: vehicleDetails.maxCarriableCapacity,
                packages: packages
            )
            
            let estimate = packageDelivery.estimate()
            
            printTable(with: estimate)
            
        } catch {
            print("Error: \(error)")
        }
    }

    private static func printTable(with estimates: [PackageDelivery]) {
        var tableOutput = [
            ["Package Id", "Package Discount", "Package Price", "Delivery Time"],
        ]

        for element in estimates.sorted(by: { $0.packageId < $1.packageId } ) {
            var roundedDuration = ""
            if let duration = element.duration {
                roundedDuration = String(format: "%.2f", duration)
            }
            tableOutput.append([element.packageId, "\(element.discount ?? 0)", "\(element.deliveryCost ?? 0)", roundedDuration])
        }
        
        print("Calculated delivery time along with discount and price")
        Utility.printTable(from: tableOutput)
    }
}

//
//  askVehicleDetails.swift
//
//
//  Created by Bhavin Bhadani on 21/03/24.
//

import Foundation

struct DeliveryInputs {
    
    static func askBasicNumbersForPackages() throws -> BasicPackageInfo {
        print("Enter The Base Delivery Cost:".green)
        guard let cost = readLine(), let cost = Int(cost) else {
            fatalError("Invalid base delivery cost value".red)
        }

        print("Enter Number of Packages:".green)
        guard let packages = readLine(), let packages = Int(packages) else {
            fatalError("Invalid number of packages value".red)
        }

        return BasicPackageInfo(basePrice: cost, packages: packages)
    }

    static func askQuestionsForDeliveryCost() throws -> DeliveryCostDetails {
        print("Enter Package ID:".green)
        guard let packageId = readLine(), !packageId.isEmpty else {
            fatalError("Package ID cannot be empty".red)
        }
        
        print("Enter Package Weight in kg:".green)
        guard let packageWeight = readLine(), let packageWeight = Int(packageWeight) else {
            fatalError("Invalid package weight value".red)
        }
        
        print("Enter Package Disatance in km:".green)
        guard let packageDistance = readLine(), let packageDistance = Int(packageDistance) else {
            fatalError("Invalid package distance value".red)
        }
        
        print("Enter Offer Code:".green)
        guard let offerCode = readLine() else {
            fatalError("Invalid value".red)
        }
        
        return DeliveryCostDetails(packageId: packageId, packageWeight: packageWeight, distance: packageDistance, offerCode: offerCode)
    }

    static func askVehicleDetails() throws -> VehicleDetails {
        print("Enter The Number of Vehicles :".green)
        guard let vehicles = readLine(), let vehicles = Int(vehicles) else {
            fatalError("Invalid number of Vehicle value".red)
        }
        
        print("Enter The Maximum Speed of Vehicle:".green)
        guard let speed = readLine(), let speed = Int(speed) else {
            fatalError("Invalid maximum speed value".red)
        }
        
        print("Enter The Maximum Carriable Capacity of Vehicle:".green)
        guard let capacity = readLine(), let capacity = Int(capacity) else {
            fatalError("Invalid maximum carriable capacity value".red)
        }

        return VehicleDetails(totalVehicles: vehicles, maxCarriableCapacity: capacity, maxSpeed: speed)
    }

}

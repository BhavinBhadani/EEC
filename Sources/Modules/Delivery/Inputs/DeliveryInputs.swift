//
//  askVehicleDetails.swift
//
//
//  Created by Bhavin Bhadani on 21/03/24.
//

import Foundation
import Models

struct DeliveryInputs {
    
    static func askPackageDetails() throws -> (basePrice: Int, numberOfPackages: Int) {
        print("Enter The Base Delivery Cost:".green)
        guard let cost = readLine(), let cost = Int(cost) else {
            fatalError("Invalid base delivery cost value".red)
        }

        print("Enter Number of Packages:".green)
        guard let packages = readLine(), let packages = Int(packages) else {
            fatalError("Invalid number of packages value".red)
        }

        return (cost, packages)
    }

    static func askVehicleDetails() throws -> (totalVehicles: Int, maxCarriableCapacity: Int, maxSpeed: Int) {
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

        return (vehicles, capacity, speed)
    }

}

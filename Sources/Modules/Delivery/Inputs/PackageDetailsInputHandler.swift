//
//  File.swift
//  
//
//  Created by Bhavin Bhadani on 03/04/24.
//

import Foundation
import Models
import Utils

struct PackageDetailsInputHandler {
    
    static func getPackageDetails() throws -> (packageId: String, weight: Int, distance: Int, offerCode: String?) {
        print("Enter Package ID:".green)
        guard let packageId = readLine(), !packageId.isEmpty else {
            throw InputError.invalidValue("Package ID cannot be empty")
        }
        
        print("Enter Package Weight in kg:".green)
        guard let packageWeightStr = readLine(), let packageWeight = Int(packageWeightStr) else {
            throw InputError.invalidValue("Invalid package weight value")
        }
        
        print("Enter Package Distance in km:".green)
        guard let distanceStr = readLine(), let distance = Int(distanceStr) else {
            throw InputError.invalidValue("Invalid package distance value")
        }
        
        print("Enter Offer Code:".green)
        let offerCode = readLine()
        
        return (packageId, packageWeight, distance, offerCode)
    }
}

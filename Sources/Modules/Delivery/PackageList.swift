//
//  File.swift
//
//
//  Created by Bhavin Bhadani on 03/04/24.
//

import Foundation
import Models

public struct PackageList {
    
    public static func getPackageDetails() throws -> [Package] {
        do {
            let packageInfo = try DeliveryInputs.askPackageDetails()
            var packageList: [Package] = []
            
            for _ in 0..<packageInfo.numberOfPackages {
                let packageDetail = try PackageDetailsInputHandler.getPackageDetails()
                packageList.append(
                    Package(packageId: packageDetail.packageId,
                            basePrice: packageInfo.basePrice,
                            weight: packageDetail.weight,
                            distance: packageDetail.distance,
                            offerCode: packageDetail.offerCode)
                )
            }
            
            return packageList
        } catch let inputError {
            throw inputError
        }
    }
    
}

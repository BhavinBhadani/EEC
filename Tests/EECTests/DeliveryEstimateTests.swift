//
//  DeliveryEstimateTests.swift
//  
//
//  Created by Bhavin Bhadani on 30/03/24.
//

import XCTest
//@testable import EEC
@testable import Models
@testable import Modules
@testable import Utils

final class DeliveryEstimateTests: XCTestCase {

    func testDeliveryEstimate() {
        let orderA = PackageDetails(packageId: "PKG1", weight: 50, distance: 30, offerCode: "OFR001")
        let orderB = PackageDetails(packageId: "PKG2", weight: 75, distance: 125, offerCode: "OFR008")
        let orderC = PackageDetails(packageId: "PKG3", weight: 175, distance: 100, offerCode: "OFR003")
        let orderD = PackageDetails(packageId: "PKG4", weight: 110, distance: 60, offerCode: "OFR002")
        let orderE = PackageDetails(packageId: "PKG5", weight: 155, distance: 95, offerCode: "NA")
                
        let estimated = PackageDeliveryTimeWrapper.estimate(
            noOfVehicles: 2,
            maxSpeed: 70,
            maxWeight: 200,
            packages: [orderA, orderB, orderC, orderD, orderE],
            basePrice: 100
        )
        
        let orderAe = estimated.first { $0.packageId == "PKG1" }
        let orderBe = estimated.first { $0.packageId == "PKG2" }
        let orderCe = estimated.first { $0.packageId == "PKG3" }
        let orderDe = estimated.first { $0.packageId == "PKG4" }
        let orderEe = estimated.first { $0.packageId == "PKG5" }

        XCTAssertNotNil(orderAe)
        XCTAssertNotNil(orderBe)
        XCTAssertNotNil(orderCe)
        XCTAssertNotNil(orderDe)
        XCTAssertNotNil(orderEe)
        
        XCTAssertEqual(orderAe?.duration ?? 0, 4, accuracy: 0.05)
        XCTAssertEqual(orderBe?.duration ?? 0, 1.78, accuracy: 0.02)
        XCTAssertEqual(orderCe?.duration ?? 0, 1.42, accuracy: 0.02)
        XCTAssertEqual(orderDe?.duration ?? 0, 0.85, accuracy: 0.02)
        XCTAssertEqual(orderEe?.duration ?? 0, 4.20, accuracy: 0.02)
    }

}

//
//  DeliveryCostTests.swift
//
//
//  Created by Bhavin Bhadani on 22/03/24.
//

import XCTest
@testable import Models
@testable import Modules
@testable import Utils

final class DeliveryCostTests: XCTestCase {

    // Test case to verify if offer codes are successfully read from file
    func testReadOfferCodesFromFile() {
        let offers = GetOffers.readOfferCodesFromFile()
        XCTAssertNotNil(offers, "Failed to read offer codes from file")
    }

    // Test case to check if discount is applied correctly when offer code is valid
    // Base.delivery cost: 100 | Weight: 5kg | Distance: 5km | Offer code: OFR001
    func testOfferNotApplicable() {
        let offers = GetOffers.readOfferCodesFromFile()
        XCTAssertNotNil(offers, "Failed to read offer codes from file")

        // Mock data
        let packageId = "PKG1"
        let packageWeight = 5
        let distance = 5
        let offerCode = "OFR001"
        let basePrice = 100
        let costOfUnitDistance = 5
        let costOfUnitWeight = 10
        
        let packageDiscount = PackageDiscount(packageId: packageId,
                                              packageWeight: packageWeight,
                                              distance: distance,
                                              offerCode: offerCode,
                                              basePrice: basePrice,
                                              costOfUnitDistance: costOfUnitDistance,
                                              costOfUnitWeight: costOfUnitWeight)

        let result = packageDiscount.calculateDiscount()
        
        XCTAssertEqual(result?.discount, 0, "Discount should be 0")
        XCTAssertEqual(result?.price, 175, "Final cost after discount should be 175")
        XCTAssertEqual((result?.price ?? 0) + (result?.discount ?? 0), 175, "Total cost should be 175")
    }
    
    // Test case to check if discount is applied correctly when offer code is valid
    // Base.delivery cost: 100 | Weight: 10kg | Distance: 100km | Offer code: OFR003
    func testOfferApplicable() {
        let offers = GetOffers.readOfferCodesFromFile()
        XCTAssertNotNil(offers, "Failed to read offer codes from file")

        // Mock data
        let packageId = "PKG3"
        let packageWeight = 10
        let distance = 100
        let offerCode = "OFR003"
        let basePrice = 100
        let costOfUnitDistance = 5
        let costOfUnitWeight = 10
        
        let packageDiscount = PackageDiscount(packageId: packageId,
                                              packageWeight: packageWeight,
                                              distance: distance,
                                              offerCode: offerCode,
                                              basePrice: basePrice,
                                              costOfUnitDistance: costOfUnitDistance,
                                              costOfUnitWeight: costOfUnitWeight)

        let result = packageDiscount.calculateDiscount()

        XCTAssertEqual(result?.discount, 35, "Discount should be 35")
        XCTAssertEqual(result?.price, 665, "Final cost after discount should be 665")
        XCTAssertEqual((result?.price ?? 0) + (result?.discount ?? 0), 700, "Total cost should be 700")
    }
    
    // Test case to check if discount is not applied when offer code is invalid
    // Base.delivery cost: 100 | Weight: 120kg | Distance: 80km | Offer code: "INVALID"
    func testNoDiscountApplied() {
        // Mock data with invalid offer code
        let packageId = "PKG2"
        let packageWeight = 120
        let distance = 80
        let offerCode = "INVALID"
        let basePrice = 100
        let costOfUnitDistance = 5
        let costOfUnitWeight = 10
        
        let packageDiscount = PackageDiscount(packageId: packageId,
                                              packageWeight: packageWeight,
                                              distance: distance,
                                              offerCode: offerCode,
                                              basePrice: basePrice,
                                              costOfUnitDistance: costOfUnitDistance,
                                              costOfUnitWeight: costOfUnitWeight)

        let result = packageDiscount.calculateDiscount()

        XCTAssertEqual(result?.discount, 0, "Discount should be 0")
        XCTAssertEqual(result?.price, 1700, "Price should be 1700")
    }
}

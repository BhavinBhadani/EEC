//
//  GetOffersTests.swift
//
//
//  Created by Bhavin Bhadani on 22/03/24.
//

import XCTest
@testable import EEC
import Models
import Modules
import Utils

class GetOffersTests: XCTestCase {

    // Test case to verify if offer codes are successfully read from file
    func testReadOfferCodesFromFile() {
        let offers = GetOffers.readOfferCodesFromFile()
        XCTAssertNotNil(offers, "Failed to read offer codes from file")
    }

    // Test case to check if discount is applied correctly when offer code is valid
    func testDiscountApplied() {
        let offers = GetOffers.readOfferCodesFromFile()
        XCTAssertNotNil(offers, "Failed to read offer codes from file")

        // Mock data
        let packageId = "PKG1"
        let packageWeight = 80
        let distance = 100
        let offerCode = "OFR001"
        let basePrice = 100
        let costOfUnitDistance = 5
        let costOfUnitWeight = 10
        
        let result = PackageDeliveryDiscount.getPackagePriceDiscount(packageId: packageId, packageWeight: packageWeight, distance: distance, offerCode: offerCode, basePrice: basePrice, costOfUnitDistance: costOfUnitDistance, costOfUnitWeight: costOfUnitWeight)
        
        XCTAssertEqual(result?.discount, 140, "Discount should be 140")
        XCTAssertEqual(result?.price, 1260, "Price should be 1260")
    }
    
    // Test case to check if discount is not applied when offer code is invalid
    func testNoDiscountApplied() {
        // Mock data with invalid offer code
        let packageId = "PKG2"
        let packageWeight = 120
        let distance = 80
        let offerCode = "INVALID"
        let basePrice = 100
        let costOfUnitDistance = 5
        let costOfUnitWeight = 10
        
        let result = PackageDeliveryDiscount.getPackagePriceDiscount(packageId: packageId, packageWeight: packageWeight, distance: distance, offerCode: offerCode, basePrice: basePrice, costOfUnitDistance: costOfUnitDistance, costOfUnitWeight: costOfUnitWeight)
        
        XCTAssertEqual(result?.discount, 0, "Discount should be 0")
        XCTAssertEqual(result?.price, 1700, "Price should be 1700")
    }
    
//    // Test case to check if discount is 0
//    func testDiscountIsZero() {
//        DeliveryCostDetails(packageId: "PKG001", packageWeight: 5, distance: 5, offerCode: "OFR001")
//        let bill1 = bill(100, Package(id: "PKG1", distance: 5, weight: 5, couponCode: "OFR001"))
//        XCTAssertEqual(bill1.discount, 0, "Discount should be 0")
//        
//        let bill2 = bill(100, Package(id: "PKG2", distance: 5, weight: 15, couponCode: "OFR001"))
//        XCTAssertEqual(bill2.discount, 0, "Discount should be 0")
//    }
//    
//    // Test case to check if discount is 35
//    func testDiscountIs35() {
//        let bill3 = bill(100, Package(id: "PKG3", distance: 100, weight: 10, couponCode: "OFR003"))
//        XCTAssertEqual(bill3.discount, 35, "Discount should be 35")
//    }
}

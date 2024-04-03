//
//  AddOfferTests.swift
//  
//
//  Created by Bhavin Bhadani on 03/04/24.
//

import XCTest
@testable import Models
@testable import Modules
@testable import Utils

final class AddOfferTests: XCTestCase {

    func testCouponCreation() throws {
        let newOffer = NewOffer(offerId: "", discount: 10, minWeight: 50, maxWeight: 100, minDistance: 10, maxDistance: 50)
        XCTAssertThrowsError(try newOffer.insert(), "Error thrown") { error in
            XCTAssertTrue(error is AddOfferError)
        }
    }
    
    func testFindCoupon() {
        let offers = GetOffers.readOfferCodesFromFile()
        XCTAssertNotNil(offers, "Failed to read offer codes from file")

        XCTAssertTrue(offers?.keys.contains("OFR001") == true)
        XCTAssertTrue(offers?.keys.contains("OFR0012") == false)
    }
    
    func testValidOfferCreation() {
        let newOffer = NewOffer(offerId: "OFFER1", discount: 10, minWeight: 50, maxWeight: 100, minDistance: 10, maxDistance: 50)
        XCTAssertNoThrow(try newOffer.insert())
    }
    
    func testEmptyOfferId() {
        let newOffer = NewOffer(offerId: "", discount: 10, minWeight: 50, maxWeight: 100, minDistance: 10, maxDistance: 50)
        XCTAssertThrowsError(try newOffer.insert()) { error in
            XCTAssertEqual(error as? AddOfferError, AddOfferError.invalidCode("Error: Offer ID cannot be empty".red))
        }
    }
    
    func testInvalidRanges() {
        // Invalid weight range
        let invalidWeightOffer = NewOffer(offerId: "OFFER2", discount: 10, minWeight: 100, maxWeight: 50, minDistance: 10, maxDistance: 50)
        XCTAssertThrowsError(try invalidWeightOffer.insert()) { error in
            XCTAssertEqual(error as? AddOfferError, AddOfferError.invalidRange("Error: Invalid weight range".red))
        }
        
        // Invalid distance range
        let invalidDistanceOffer = NewOffer(offerId: "OFFER3", discount: 10, minWeight: 50, maxWeight: 100, minDistance: 50, maxDistance: 10)
        XCTAssertThrowsError(try invalidDistanceOffer.insert()) { error in
            XCTAssertEqual(error as? AddOfferError, AddOfferError.invalidRange("Error: Invalid distance range".red))
        }
    }
    
    func testOfferInsertion() {
        let newOffer = NewOffer(offerId: "OFFER4", discount: 10, minWeight: 50, maxWeight: 100, minDistance: 10, maxDistance: 50)
        XCTAssertNoThrow(try newOffer.insert())
    }
}

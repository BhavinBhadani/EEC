//
//  VehicleDetails.swift
//
//
//  Created by Bhavin Bhadani on 21/03/24.
//

import Foundation

public struct VehicleDetails {
    public let totalVehicles: Int
    public let maxCarriableCapacity: Int
    public let maxSpeed: Int
    
    public init(totalVehicles: Int, maxCarriableCapacity: Int, maxSpeed: Int) {
        self.totalVehicles = totalVehicles
        self.maxCarriableCapacity = maxCarriableCapacity
        self.maxSpeed = maxSpeed
    }
}

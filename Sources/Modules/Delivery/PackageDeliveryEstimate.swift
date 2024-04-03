//
//  File.swift
//  
//
//  Created by Bhavin Bhadani on 03/04/24.
//

import Foundation
import Models
import Utils

public struct PackageDeliveryEstimate {
    public let numberOfVehicles: Int
    public let maxSpeed: Int
    public let maxWeight: Int
    public let packages: [Package]
    
    public init(numberOfVehicles: Int, maxSpeed: Int, maxWeight: Int, packages: [Package]) {
        self.numberOfVehicles = numberOfVehicles
        self.maxSpeed = maxSpeed
        self.maxWeight = maxWeight
        self.packages = packages
    }
    
    public func estimate() -> [PackageDelivery] {
        let packages = packages.sorted { $0.weight > $1.weight }
        var shipments: [[Package]] = []

        var counter = 0
        while counter < packages.count {
            var containerWeight = 0
            var container: [Package] = []

            for i in counter..<packages.count {
                if containerWeight + packages[i].weight > maxWeight {
                    break
                }
                counter += 1
                containerWeight += packages[i].weight
                container.append(packages[i])
            }
            shipments.append(container)
        }

        shipments.sort { $0.count > $1.count }

        var vehicles = Array(repeating: Double(0), count: numberOfVehicles)

        var orders: [PackageDelivery] = []

        for shipment in shipments {
            vehicles.sort()
            var maxTime: Double = 0
            for order in shipment {
                let packageDiscount = PackageDiscount(packageId: order.packageId,
                                                      packageWeight: order.weight,
                                                      distance: order.distance,
                                                      offerCode: order.offerCode,
                                                      basePrice: order.basePrice)
                
                let discountedResult = packageDiscount.calculateDiscount()
                
                let timeForOrder = Double(order.distance) / Double(maxSpeed)
                let eta = Double(vehicles[0]) + timeForOrder
                let packageOrder = PackageDelivery(
                    packageId: order.packageId,
                    discount: discountedResult?.discount ?? 0,
                    deliveryCost: discountedResult?.price ?? 0,
                    duration: eta
                )

                if timeForOrder > Double(maxTime) {
                    maxTime = timeForOrder
                }
                orders.append(packageOrder)
            }
            vehicles[0] += 2 * maxTime
        }

        return orders
    }

}

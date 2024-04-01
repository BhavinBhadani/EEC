//
//  PackageDeliveryTime.swift
//
//
//  Created by Bhavin Bhadani on 22/03/24.
//

import Foundation
import Models
import Utils

public struct PackageDeliveryTimeWrapper {
    
    public static func getAllPackageDeliveryTime() {
        do {
            let packageInfo = try DeliveryInputs.askBasicNumbersForPackages()
            var packageList: [PackageDetails] = []
            
            var tableOutput = [
                ["Package Id", "Package Discount", "Package Price", "Delivery Time"],
            ]

            for _ in 0..<packageInfo.packages {
                let deliveryCostDetails = try DeliveryInputs.askQuestionsForDeliveryCost()
                packageList.append(PackageDetails(packageId: deliveryCostDetails.packageId, weight: deliveryCostDetails.packageWeight, distance: deliveryCostDetails.distance, offerCode: deliveryCostDetails.offerCode))
            }
            
            let vehicleDetails = try DeliveryInputs.askVehicleDetails()
            
            let packageDeliveryTimes = estimate(
                noOfVehicles: vehicleDetails.totalVehicles,
                maxSpeed: vehicleDetails.maxSpeed,
                maxWeight: vehicleDetails.maxCarriableCapacity,
                packages: packageList,
                basePrice: packageInfo.basePrice
            )
                        
            for element in packageDeliveryTimes.sorted(by: { $0.packageId < $1.packageId } ) {
                if let duration = element.duration {
                    let roundedDuration = String(format: "%.2f", duration)
                    tableOutput.append([element.packageId, "\(element.discount ?? 0)", "\(element.deliveryCost ?? 0)", "\(roundedDuration)"])
                }
            }
            
            print("Calculated delivery time along with discount and price")
            Utility.printTable(from: tableOutput)
        } catch {
            print("Error: \(error)")
        }
    }

    public static func estimate(noOfVehicles: Int, maxSpeed: Int, maxWeight: Int, packages: [PackageDetails], basePrice: Int) -> [PackageDeliveryTime] {
        let packages = packages.sorted { $0.weight > $1.weight }
        var shipments: [[PackageDetails]] = []

        var counter = 0
        while counter < packages.count {
            var containerWeight = 0
            var container: [PackageDetails] = []

            for i in counter..<packages.count {
                if containerWeight + packages[i].weight > maxWeight {
                    //fatalError("Package weight can't be more than max vehicle weight capacity")
                    break
                }
                counter += 1
                containerWeight += packages[i].weight
                container.append(packages[i])
            }
            shipments.append(container)
        }

        shipments.sort { $0.count > $1.count }

        var vehicles = Array(repeating: Double(0), count: noOfVehicles)

        var orders: [PackageDeliveryTime] = []

        for shipment in shipments {
            vehicles.sort()
            var maxTime: Double = 0
            for order in shipment {
                let packagePriceDiscount = PackageDeliveryDiscount.getPackagePriceDiscount(
                    packageId: order.packageId,
                    packageWeight: order.weight,
                    distance: order.distance,
                    offerCode: order.offerCode,
                    basePrice: basePrice
                )
                
                let timeForOrder = Double(order.distance) / Double(maxSpeed)
                let eta = Double(vehicles[0]) + timeForOrder
                let packageOrder = PackageDeliveryTime(
                    packageId: order.packageId,
                    discount: packagePriceDiscount?.discount ?? 0,
                    deliveryCost: packagePriceDiscount?.price ?? 0,
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

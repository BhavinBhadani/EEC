//
//  PackageDeliveryTime.swift
//
//
//  Created by Bhavin Bhadani on 22/03/24.
//

import Foundation
import Models
import Utils

public enum PackageDeliveryTimeWrapper {
    
    public static func getAllPackageDeliveryTime() {
        do {
            let packageInfo = try DeliveryInputs.askBasicNumbersForPackages()
            var packageList: [PackageDetails] = []
            
            var tableOutput = [
                ["Package Id", "Package Discount", "Package Price", "Delivery Time"],
            ]

            for i in 0..<packageInfo.packages {
                print("Enter the details of package \(i + 1)")
                
                let deliveryCostDetails = try DeliveryInputs.askQuestionsForDeliveryCost()
                packageList.append(PackageDetails(packageId: deliveryCostDetails.packageId, weight: deliveryCostDetails.packageWeight, distance: deliveryCostDetails.distance, offerCode: deliveryCostDetails.offerCode, index: i))
            }
            
            let vehicleDetails = try DeliveryInputs.askVehicleDetails()
            
            let packageDeliveryTimes = getPackageDeliveryTime(noOfPackages: packageInfo.packages, packageList: packageList, noOfVehicles: vehicleDetails.totalVehicles, maxSpeed: vehicleDetails.maxSpeed, maxCarriableCapacity: vehicleDetails.maxCarriableCapacity, basePrice: packageInfo.basePrice)
            
            for element in packageDeliveryTimes {
                if let duration = element.duration {
                    tableOutput.append([element.packageId, "\(element.discount ?? 0)", "\(element.deliveryCost ?? 0)", "\(duration)"])
                }
            }
            
            print("Calculated delivery time along with discount and price")
            Utility.printTable(from: tableOutput)
        } catch {
            print("Error: \(error)")
        }
    }

    private static func getPackageDeliveryTime(noOfPackages: Int, packageList: [PackageDetails], noOfVehicles: Int, maxSpeed: Int, maxCarriableCapacity: Int, basePrice: Int) -> [PackageDeliveryTime] {
        guard noOfPackages > 0, !packageList.isEmpty, maxSpeed > 0, noOfVehicles > 0, maxCarriableCapacity > 0 else {
            return []
        }

        var vehicleAvailabilityArray = Array(repeating: Double(0), count: noOfVehicles)
        var newUpdatedPackageList = packageList
        var packagesWithDuration: [PackageDeliveryTime] = []
        
        while !newUpdatedPackageList.isEmpty {
            let possibleShipmentList = getNextPossibleShipmentsList(packageList: newUpdatedPackageList, maxCarriableCapacity: maxCarriableCapacity)
            let nextDelivery = getClosestShipment(possibleShipmentList: possibleShipmentList, packageList: packageList)
            let nextAvailabeAt = vehicleAvailabilityArray.min() ?? 0
            var durationForSingleTrip: Double = 0
            
            for element in nextDelivery {
                let currentPackage = packageList[element]
                let deliveryTime = Double(currentPackage.distance) / Double(maxSpeed)
                
                let packagePriceDiscount = PackageDeliveryDiscount.getPackagePriceDiscount(
                    packageId: currentPackage.packageId,
                    packageWeight: currentPackage.weight,
                    distance: currentPackage.distance,
                    offerCode: currentPackage.offerCode,
                    basePrice: basePrice
                )
                
                let calculatedTimeOfPkg = PackageDeliveryTime(
                    packageId: currentPackage.packageId,
                    discount: packagePriceDiscount?.discount ?? 0,
                    deliveryCost: packagePriceDiscount?.price ?? 0,
                    duration: Double(nextAvailabeAt) + deliveryTime
                )
                
                durationForSingleTrip = max(deliveryTime, durationForSingleTrip)
                packagesWithDuration.append(calculatedTimeOfPkg)
            }
            
            vehicleAvailabilityArray[vehicleAvailabilityArray.firstIndex(of: nextAvailabeAt)!] = nextAvailabeAt + 2 * durationForSingleTrip
            
            newUpdatedPackageList = newUpdatedPackageList.filter { package in
                return !nextDelivery.contains(package.index)
            }
        }
        
        return packagesWithDuration
    }

    private static func getClosestShipment(possibleShipmentList: [[Int]], packageList: [PackageDetails]) -> [Int] {
        if possibleShipmentList.count == 1 {
            return possibleShipmentList[0]
        }
        
        var distanceList: [Int] = []
        
        for element in possibleShipmentList {
            var distance = 0
            for ele in element {
                distance = max(distance, packageList[ele].weight)
            }
            distanceList.append(distance)
        }
        
        let minDistance = distanceList.min() ?? 0
        guard let closestIndex = distanceList.firstIndex(of: minDistance) else {
            return []
        }
        
        let closestShipment = possibleShipmentList[closestIndex]
        return closestShipment
    }

    private static func getNextPossibleShipmentsList(packageList: [PackageDetails], maxCarriableCapacity: Int) -> [[Int]] {
        if packageList.isEmpty || maxCarriableCapacity <= 0 {
            return []
        }
        
        var possiblePackages: [[PackageDetails]] = []
        var localHighestSum = 0
        var possiblePackagesIndices: [[Int]] = []
        
        for i in 1 ..< (1 << packageList.count) {
            var subset: [PackageDetails] = []
            
            for j in 0 ..< packageList.count {
                if (i & (1 << j)) != 0 {
                    subset.append(packageList[j])
                }
            }
            
            var temp = 0
            for element in subset {
                temp += element.weight
            }
            
            if temp <= maxCarriableCapacity && temp >= localHighestSum {
                localHighestSum = temp
                possiblePackages.append(subset)
            }
        }
        
        possiblePackages = possiblePackages.filter { element in
            element.reduce(0, { $0 + $1.weight }) == localHighestSum
        }
        
        possiblePackages.forEach { element in
            var temp: [Int] = []
            for ele in element {
                temp.append(ele.index)
            }
            possiblePackagesIndices.append(temp)
        }
        
        return possiblePackagesIndices
    }

}

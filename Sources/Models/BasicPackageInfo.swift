//
//  BasicPackageInfo.swift
//  
//
//  Created by Bhavin Bhadani on 21/03/24.
//

import Foundation

public struct BasicPackageInfo {
    public let basePrice: Int
    public let packages: Int
    
    public init(basePrice: Int, packages: Int) {
        self.basePrice = basePrice
        self.packages = packages
    }
}

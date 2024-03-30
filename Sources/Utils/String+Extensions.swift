//
//  String+Extensions.swift
//
//
//  Created by Bhavin Bhadani on 21/03/24.
//

import Foundation

extension String {
    public var green: String {
        "\u{001B}[0;32m" + self + "\u{001B}[0m"
    }
    
    public var red: String {
        "\u{001B}[0;31m" + self + "\u{001B}[0m"
    }
    
    public var yellow: String {
        "\u{001B}[0;33m" + self + "\u{001B}[0m"
    }
    
    public var cyan: String {
        "\u{001B}[0;36m" + self + "\u{001B}[0m"
    }
    
    public var purple: String {
        "\u{001B}[0;35m" + self + "\u{001B}[0m"
    }
    
    public var blue: String {
        "\u{001B}[0;34m" + self + "\u{001B}[0m"
    }
    
    public var grey: String {
        "\u{001B}[0;90m" + self + "\u{001B}[0m"
    }
}

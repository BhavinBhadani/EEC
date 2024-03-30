//
//  String+Extensions.swift
//
//
//  Created by Bhavin Bhadani on 21/03/24.
//

import Foundation

extension String {
    var green: String {
        "\u{001B}[0;32m" + self + "\u{001B}[0m"
    }
    
    var red: String {
        "\u{001B}[0;31m" + self + "\u{001B}[0m"
    }
    
    var yellow: String {
        "\u{001B}[0;33m" + self + "\u{001B}[0m"
    }
    
    var cyan: String {
        "\u{001B}[0;36m" + self + "\u{001B}[0m"
    }
    
    var purple: String {
        "\u{001B}[0;35m" + self + "\u{001B}[0m"
    }
    
    var blue: String {
        "\u{001B}[0;34m" + self + "\u{001B}[0m"
    }
    
    var grey: String {
        "\u{001B}[0;90m" + self + "\u{001B}[0m"
    }
}

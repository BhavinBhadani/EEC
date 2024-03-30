//
//  File.swift
//  
//
//  Created by Bhavin Bhadani on 21/03/24.
//

import Foundation

final class Utility {
    
    class func printTable(from data: [[String]]) {
        if data.isEmpty { return }
        
        let headerColors = Array(repeating: "\u{001B}[0;36m", count: data[0].count)
        
        // Calculate column widths
        let columnWidths = data[0].map { $0.count + 4 }
        
        // Print top border
        let topBorder = "┌" + columnWidths.map { "─" * $0 }.joined(separator: "┬") + "┐"
        print(topBorder.grey)

        // Print header row
        let headerRow = "│".grey + zip(data[0], headerColors).enumerated().map { index, tuple in
            let (text, color) = tuple
            return "\(color)\(text.padding(toLength: columnWidths[index], withPad: " ", startingAt: 0))"
        }.joined(separator: "│".grey) + "│".grey
        print(headerRow)

        // Print middle border
        let middleRow = "├" + columnWidths.map { "─" * $0 }.joined(separator: "┼") + "┤"
        print(middleRow.grey)

        // Print data rows
        for row in data[1...] {
            let rows = "│".grey + zip(row, columnWidths).map { $0.padding(toLength: $1, withPad: " ", startingAt: 0) }.joined(separator: "│".grey) + "│".grey
            print(rows)
        }

        // Print bottom border
        let bottomRow = "└" + columnWidths.map { "─" * $0 }.joined(separator: "┴") + "┘"
        print(bottomRow.grey)
    }
    
}

func isBetween<T: Comparable>(_ value: T, _ min: T, _ max: T) -> Bool {
    return value >= min && value <= max
}

func * (lhs: String, rhs: Int) -> String {
    return String(repeating: lhs, count: rhs)
}

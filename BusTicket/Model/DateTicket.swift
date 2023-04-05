//
//  DateTicket.swift
//  BusTicket
//
//  Created by mertcan YAMAN on 5.04.2023.
//

import Foundation

struct DateTicket {
    var day: Int = 1
    var month: Int = 1
    var year: Int = 2021
    
    func printDate() {
        print("\(day)/\(month)/\(year)")
    }
}

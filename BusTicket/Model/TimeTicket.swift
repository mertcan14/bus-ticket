//
//  TimeTicket.swift
//  BusTicket
//
//  Created by mertcan YAMAN on 5.04.2023.
//

import Foundation

struct TimeTicket {
    var hour: Int = 0
    var minute: Int = 0
    
    func printTime() {
        print("\(hour):\(minute)")
    }
}

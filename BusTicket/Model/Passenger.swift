//
//  Passenger.swift
//  BusTicket
//
//  Created by mertcan YAMAN on 5.04.2023.
//

import Foundation

struct Passenger {
    var id: Int = 0
    var firstName: String = "İsimsiz"
    var lastName: String = "İsimsiz"
    
    func printPassenger() {
        print("\(firstName) - \(lastName) - \(id)")
    }
}

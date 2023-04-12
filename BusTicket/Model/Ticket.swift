//
//  Ticket.swift
//  BusTicket
//
//  Created by mertcan YAMAN on 5.04.2023.
//

import Foundation


struct Ticket {
    var passenger: Passenger
    var date: DateTicket
    var time: TimeTicket
    var seat: [Int] = []
    var seatCount: Int = 0
    
    func printTicket() {
        print("\(passenger.firstName) \(passenger.lastName) \(passenger.id), \(date.day)/\(date.month)/\(date.year), \(time.hour):\(time.minute)")
    }
    
    func compareSeat(_ saleSeats: [Int]) -> Bool {
        for mySeat in seat {
            if saleSeats.contains(mySeat) {
                return true
            }
        }
        return false
    }
    
    mutating func reserveSeat(_ seatCount: Int) {
        if self.seatCount != 0 {
            return
        }
        self.seatCount = seatCount
        self.seat.reserveCapacity(seatCount)
    }
    
    mutating func addSeat(_ seatNo: Int) {
        seat.append(seatNo)
    }
}

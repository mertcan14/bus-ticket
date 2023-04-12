//
//  MockSeatCreater.swift
//  BusTicket
//
//  Created by mertcan YAMAN on 6.04.2023.
//

import Foundation

struct SeatStub {
    let id: String
    let number: Int
    let salable: Bool
    var gender: Bool
    let hall: Bool
}

class MockSeatCreater {
    
    func create(count: Int, type: String) -> [SeatStub] {
        var list = [SeatStub]()
        var seatNumber = 1
        var totalSpace = 0
        if type == "2+2" {
            while seatNumber-totalSpace != count+1 {
                var isHall = (seatNumber - 2) % 5 == 1
                if (seatNumber - totalSpace + 5) > count {
                    isHall = false
                }
                if isHall {
                    totalSpace += 1
                }
                let stub = SeatStub(id: UUID().uuidString,
                                    number: seatNumber - totalSpace,
                                    salable: Bool.random(),
                                    gender: true,
                                    hall: isHall)
                list.append(stub)
                seatNumber += 1
            }
        }else {
            while seatNumber-totalSpace != count+1 {
                let isHall = (seatNumber - 1) % 5 == 1
                if isHall {
                    totalSpace += 2
                    
                    let stub = SeatStub(id: UUID().uuidString,
                                        number: seatNumber - totalSpace,
                                        salable: Bool.random(),
                                        gender: true,
                                        hall: isHall)
                    list.append(stub)
                    seatNumber += 1
                }
                
                let stub = SeatStub(id: UUID().uuidString,
                                    number: seatNumber - totalSpace,
                                    salable: Bool.random(),
                                    gender: true,
                                    hall: isHall)
                list.append(stub)
                seatNumber += 1
            }
        }
        let soldSeat = list.filter { seat in
            return !seat.salable
        }
        NotificationCenter.default.post(name: Notification.Name(rawValue: "soldSeatList"), object: soldSeat)
        return list
    }
    
}

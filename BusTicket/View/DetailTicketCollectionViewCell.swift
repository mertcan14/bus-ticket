//
//  DetailTicketCollectionViewCell.swift
//  BusTicket
//
//  Created by mertcan YAMAN on 10.04.2023.
//

import UIKit

class DetailTicketCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var arrivalTime: UILabel!
    @IBOutlet weak var arrivalDate: UILabel!
    @IBOutlet weak var departureTime: UILabel!
    @IBOutlet weak var departureDate: UILabel!
    @IBOutlet weak var busID: UILabel!
    @IBOutlet weak var busBrand: UILabel!
    @IBOutlet weak var seatNo: UILabel!
    @IBOutlet weak var passengerName: UILabel!
    @IBOutlet weak var placeArrival: UILabel!
    @IBOutlet weak var placeDeparture: UILabel!
    
    func setup(_ ticket: Ticket, seatNumber: String) {
        arrivalTime.text = "\(ticket.time.hour):\(ticket.time.minute)"
        departureTime.text = "\(ticket.time.hour):\(ticket.time.minute)"
        arrivalDate.text = "\(ticket.date.day)/\(ticket.date.month)/\(ticket.date.year)"
        departureDate.text = "\(ticket.date.day)/\(ticket.date.month)/\(ticket.date.year)"
        busID.text = "28388373"
        busBrand.text = "Kamil Koç"
        seatNo.text = seatNumber
        passengerName.text = "\(ticket.passenger.firstName) \(ticket.passenger.lastName)"
        placeArrival.text = "Ankara"
        placeDeparture.text = "Bolu"
    }
}

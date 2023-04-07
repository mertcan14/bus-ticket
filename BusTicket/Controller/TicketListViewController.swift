//
//  TicketListViewController.swift
//  BusTicket
//
//  Created by mertcan YAMAN on 5.04.2023.
//

import UIKit

class TicketListViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    var dateForTicket: DateTicket = DateTicket()
    var fromForTicket: String = ""
    var toForTicket: String = ""
    var busInfo: BusInfo = BusInfo()
    
    let busInfos: [BusInfo] = [
        BusInfo(brand: "Kamil Koç", content: "A/C Sleepers 2+2", depatureTime: "6:00 AM", arrivalTime: "10:00 AM", time: "4 Hours", price: "250 TL"),
        BusInfo(brand: "Metro Turizm", content: "A/C Sleepers 2+1", depatureTime: "7:00 AM", arrivalTime: "12:00 AM", time: "5 Hours", price: "350 TL"),
        BusInfo(brand: "VIP", content: "A/C Sleepers 2+1", depatureTime: "8:00 AM", arrivalTime: "13:30 AM", time: "3.5 Hours", price: "300 TL"),
        BusInfo(brand: "Kamil Koç", content: "A/C Sleepers 2+2", depatureTime: "3:00 PM", arrivalTime: "7:00 PM", time: "4 Hours", price: "270 TL"),
        BusInfo(brand: "Kamil Koç", content: "A/C Sleepers 2+2", depatureTime: "3:00 PM", arrivalTime: "7:00 PM", time: "4 Hours", price: "270 TL"),
        BusInfo(brand: "Ali Osman Ulusoy", content: "A/C Sleepers 2+2", depatureTime: "3:00 PM", arrivalTime: "7:00 PM", time: "4 Hours", price: "270 TL"),
    ]
 
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.tintColor = .white
        fromLabel.text = fromForTicket
        toLabel.text = toForTicket
        dateLabel.text = "\(dateForTicket.day)-\(dateForTicket.month)-\(dateForTicket.year)"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailBusVC" {
            if let detailBusInfoVC = segue.destination as? DetailBusViewController {
                detailBusInfoVC.busInfo = self.busInfo
                detailBusInfoVC.dateForTicket = self.dateForTicket
            }
        }
    }
}

extension TicketListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        busInfos.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        busInfo = busInfos[indexPath.row]
        performSegue(withIdentifier: "toDetailBusVC", sender: nil)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "ticketCell", for: indexPath) as! TicketTableViewCell
        cell.setup(busInfos[indexPath.row])
        return cell
    }
    
    
}

//
//  DetailBusViewController.swift
//  BusTicket
//
//  Created by mertcan YAMAN on 6.04.2023.
//

import UIKit
import ALBusSeatView

class DetailBusViewController: UIViewController {
    var busInfo: BusInfo = BusInfo()
    var selectedSeats: [SeatStub] = []
    var dataManager = SeatDataManager()
    var dateForTicket: DateTicket = DateTicket()
    var ticket: Ticket?
    
    var user: Passenger = Passenger(id: 1, firstName: "Mertcan", lastName: "Yaman")
    
    @IBOutlet weak var formView: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var arrivalLabel: UILabel!
    @IBOutlet weak var departureLabel: UILabel!
    @IBOutlet weak var busBrandImage: UIImageView!
    @IBOutlet weak var firstNameTxtField: UITextField!
    @IBOutlet weak var lastNameTxtField: UITextField!
    @IBOutlet weak var tcNoTxtField: UITextField!
    @IBOutlet weak var registeredUserSwitch: UISwitch!
    @IBOutlet weak var seatView: ALBusSeatView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        seatView.config = ExampleSeatConfig()
        seatView?.delegate = dataManager
        seatView?.dataSource = dataManager
        let first = MockSeatCreater().create(count: 45)
        dataManager.seatList = [first]
        seatView?.reload()
        
        NotificationCenter.default.addObserver(self, selector: #selector(alertMaxSelected), name: Notification.Name(rawValue: "maxSelected"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(changeSelectedSeat(_:)), name: Notification.Name(rawValue: "selectedSeat"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        busBrandImage.image = UIImage(named: busInfo.brand ?? "star")
        departureLabel.text = busInfo.depatureTime
        arrivalLabel.text = busInfo.arrivalTime
        contentLabel.text = busInfo.content
        priceLabel.text = busInfo.price
        timeLabel.text = busInfo.time
        formView.layer.borderWidth = 4
        formView.layer.borderColor = UIColor(red: 1.0, green: 120/255, blue: 56/255, alpha: 1.0).cgColor
        changeUser()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let vW = view.frame.width
        seatView?.frame = CGRect(x: 0, y: 130, width: vW, height: 225)
    }
    
    @IBAction func buyBtnClicked(_ sender: Any) {
        if !selectedSeats.isEmpty {
            if !registeredUserSwitch.isOn {
                
                user.firstName = firstNameTxtField.text ?? ""
                user.lastName = lastNameTxtField.text ?? ""
                user.id = Int(tcNoTxtField.text ?? "0") ?? 0
            }
            var timeTicket = timeConvertInt(busInfo.depatureTime!)
            ticket = Ticket(passenger: user, date: dateForTicket, time: timeTicket)
            ticket?.reserveSeat(selectedSeats.count)
            for selectedSeat in selectedSeats {
                ticket?.addSeat(selectedSeat.number)
            }
            performSegue(withIdentifier: "toDetailTicketVC", sender: nil)
        }else {
            alertFunc("Not Selected Seat", "You must choose a seat")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailTicketVC" {
            if let detailTicketVC = segue.destination as? DetailTicketViewController {
                detailTicketVC.ticket = ticket
            }
        }
    }
    
    @IBAction func registeredUserChange(_ sender: Any) {
        changeUser()
    }
    
    private func changeUser() {
        if registeredUserSwitch.isOn {
            firstNameTxtField.text = user.firstName
            lastNameTxtField.text = user.lastName
            tcNoTxtField.text = "36360075668"
            
            firstNameTxtField.isEnabled = false
            lastNameTxtField.isEnabled = false
            tcNoTxtField.isEnabled = false
        }else {
            firstNameTxtField.text = ""
            lastNameTxtField.text = ""
            tcNoTxtField.text = ""
            
            firstNameTxtField.isEnabled = true
            lastNameTxtField.isEnabled = true
            tcNoTxtField.isEnabled = true
        }
    }
    
    private func timeConvertInt(_ departureTime: String) -> TimeTicket {
        let hour = departureTime.split(separator: ":")
        return TimeTicket(hour: Int(hour[0]) ?? 0, minute: Int(hour[1]) ?? 0)
    }
    
    @objc func changeSelectedSeat(_ seatList: Notification) {
        guard let selectedSeatList = seatList.object as? [SeatStub] else { return }
        self.selectedSeats = selectedSeatList
    }
    @objc func alertMaxSelected() {
        alertFunc("Max Selected", "You can choose up to 5 seats.")
    }
    
    
    func alertFunc(_ title: String, _ content: String) {
        let alert = UIAlertController(title: title, message: content, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true)
    }
    
}

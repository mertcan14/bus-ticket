//
//  DetailBusViewController.swift
//  BusTicket
//
//  Created by mertcan YAMAN on 6.04.2023.
//

import UIKit
import ALBusSeatView

class DetailBusViewController: UIViewController {
    // MARK: - IBOutlet Definitions
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
    // MARK: - Variable Definitions
    var busInfo: BusInfo = BusInfo()
    var selectedSeats: [SeatStub] = []
    var dataManager = SeatDataManager()
    var dateForTicket: DateTicket = DateTicket()
    var ticket: Ticket?
    var soldSeatList: [Int] = []
    var user: Passenger = Passenger()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        seatConfig()
        
        NotificationCenter.default.addObserver(self, selector: #selector(alertMaxSelected), name: Notification.Name(rawValue: "maxSelected"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(changeSelectedSeat(_:)), name: Notification.Name(rawValue: "selectedSeat"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(assignSoldseatList(_:)), name: Notification.Name(rawValue: "soldSeatList"), object: nil)
        
        if let data = UserDefaults.standard.data(forKey: "Passenger") {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()

                // Decode Note
                self.user = try decoder.decode(Passenger.self, from: data)

            } catch {
                print("Unable to Decode Notes (\(error))")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // configure labels
        busBrandImage.image = UIImage(named: busInfo.brand ?? "star")
        departureLabel.text = busInfo.depatureTime
        arrivalLabel.text = busInfo.arrivalTime
        contentLabel.text = busInfo.content
        priceLabel.text = busInfo.price
        timeLabel.text = busInfo.time
        changeUser()
    }
    // MARK: IBAction methods
    @IBAction func buyBtnClicked(_ sender: Any) {
        if !selectedSeats.isEmpty {
            if ((ticket?.compareSeat(soldSeatList)) == false) {
                alertFunc("Sorry", "Seats have been sold")
            }
            if !registeredUserSwitch.isOn {
                
                user.firstName = firstNameTxtField.text ?? ""
                user.lastName = lastNameTxtField.text ?? ""
                user.id = Int(tcNoTxtField.text ?? "0") ?? 0
            }
            let timeTicket = timeConvertInt(busInfo.depatureTime!)
            let id = Int(tcNoTxtField.text!) ?? 0
            let passenger: Passenger = Passenger(id: id, firstName: firstNameTxtField.text!, lastName: lastNameTxtField.text!)
            ticket = Ticket(passenger: passenger, date: dateForTicket, time: timeTicket)
            ticket?.reserveSeat(selectedSeats.count)
            for selectedSeat in selectedSeats {
                ticket?.addSeat(selectedSeat.number)
            }
            let animationPopUp = SuccessPopUp()
            animationPopUp.appear(sender: self)
            NotificationCenter.default.addObserver(self, selector: #selector(toDetailTicketVC), name: Notification.Name(rawValue: "paymenySuccess"), object: nil)
        }else {
            alertFunc("Not Selected Seat", "You must choose a seat")
        }
    }
    
    @IBAction func registeredUserChange(_ sender: Any) {
        changeUser()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailTicketVC" {
            if let detailTicketVC = segue.destination as? DetailTicketViewController {
                detailTicketVC.busInfo = busInfo
                detailTicketVC.ticket = ticket
            }
        }
    }
    /// Replace data with registered user or clear data
    private func changeUser() {
        if registeredUserSwitch.isOn {
            firstNameTxtField.text = user.firstName
            lastNameTxtField.text = user.lastName
            tcNoTxtField.text = "\(user.id)"
            
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
    
    private func seatConfig() {
        seatView.config = ExampleSeatConfig()
        seatView?.delegate = dataManager
        seatView?.dataSource = dataManager
        let typeBus: String = String(busInfo.content?.split(separator: " ").last ?? "2+2")
        
        let first = MockSeatCreater().create(count: 45, type: typeBus)
        dataManager.seatList = [first]
        seatView?.reload()
    }
    // Bus info time convert to TimeTicket object
    private func timeConvertInt(_ departureTime: String) -> TimeTicket {
        let hour = departureTime.split(separator: ":")
        return TimeTicket(hour: Int(hour[0]) ?? 0, minute: Int(hour[1]) ?? 0)
    }
    // Get sold seat list
    @objc func assignSoldseatList(_ soldSeatList: Notification) {
        guard let soldSeats = soldSeatList.object as? [Int] else { return }
        self.soldSeatList = soldSeats
    }
    
    @objc func toDetailTicketVC() {
        performSegue(withIdentifier: "toDetailTicketVC", sender: nil)
    }
    // Get selected seat list
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

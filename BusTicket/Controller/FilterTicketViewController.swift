//
//  FilterTicketViewController.swift
//  BusTicket
//
//  Created by mertcan YAMAN on 5.04.2023.
//

import UIKit

class FilterTicketViewController: UIViewController {

    var user: Passenger = Passenger(id: 1, firstName: "Mertcan", lastName: "Yaman")
    
    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var toTextField: UITextField!
    @IBOutlet weak var datePickerField: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.shadowColor = .clear
        appearance.backgroundColor = UIColor(red: 0, green: 128/255, blue: 1, alpha: 1)

        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    @IBAction func tomorrowBtnClicked(_ sender: Any) {
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date())
        datePickerField.date = tomorrow ?? Date()
    }
    @IBAction func todayBtnClicked(_ sender: Any) {
        datePickerField.date = Date()
    }
    @IBAction func changeTextFieldBtnClicked(_ sender: Any) {
        var changeValue = fromTextField.text
        fromTextField.text = toTextField.text
        toTextField.text = changeValue
    }
    @IBAction func searchBtnClicked(_ sender: Any) {
        if fromTextField.text != "" && toTextField.text != "" {
            performSegue(withIdentifier: "toTicketListVC", sender: nil)
        }else {
            print("Girişleri boş bırakamazsınız.")
        }
    }
}

//
//  FilterTicketViewController.swift
//  BusTicket
//
//  Created by mertcan YAMAN on 5.04.2023.
//

import UIKit


class FilterTicketViewController: UIViewController {
    
    
    @IBOutlet weak var toTextField: UITextField!
    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var datePickerField: UIDatePicker!
    
    let cities = [ "Adana", "Adıyaman", "Afyon", "Ağrı", "Amasya", "Ankara", "Antalya", "Artvin", "Aydın", "Balıkesir", "Bilecik", "Bingöl", "Bitlis", "Bolu", "Burdur", "Bursa", "Çanakkale", "Çankırı", "Çorum", "Denizli", "Diyarbakır", "Edirne", "Elazığ", "Erzincan", "Erzurum", "Eskişehir", "Gaziantep", "Giresun", "Gümüşhane", "Hakkari", "Hatay", "Isparta", "İçel (Mersin)", "İstanbul", "İzmir", "Kars", "Kastamonu", "Kayseri", "Kırklareli", "Kırşehir", "Kocaeli", "Konya", "Kütahya", "Malatya", "Manisa", "Kahramanmaraş", "Mardin", "Muğla", "Muş", "Nevşehir", "Niğde", "Ordu", "Rize", "Sakarya", "Samsun", "Siirt", "Sinop", "Sivas", "Tekirdağ", "Tokat", "Trabzon", "Tunceli", "Şanlıurfa", "Uşak", "Van", "Yozgat", "Zonguldak", "Aksaray", "Bayburt", "Karaman", "Kırıkkale", "Batman", "Şırnak", "Bartın", "Ardahan", "Iğdır", "Yalova", "Karabük", "Kilis", "Osmaniye", "Düzce"]
    var filteredCities: [String] = []
    var dateTicket: DateTicket = DateTicket()
    var tableView = UITableView()
    var currentTxtField = 0
    let searchController = UISearchController()
    var isFiltering = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fromTextField.delegate = self
        toTextField.delegate = self
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
        let changeValue = fromTextField.text
        fromTextField.text = toTextField.text
        toTextField.text = changeValue
    }
    @IBAction func searchBtnClicked(_ sender: Any) {
        if fromTextField.text != "" && toTextField.text != "" {
            let components = Calendar.current.dateComponents([.day, .month, .year], from: datePickerField.date)
            guard let day = components.day else { return }
            guard let month = components.month else { return }
            guard let year = components.year else { return }
            dateTicket.day = day
            dateTicket.month = month
            dateTicket.year = year
            performSegue(withIdentifier: "toTicketListVC", sender: nil)
        }else {
            print("Girişleri boş bırakamazsınız.")
        }
    }
    @IBAction func fromTxtEditBegin(_ sender: Any) {
        currentTxtField = 1
    }
    @IBAction func toTxtEditBegin(_ sender: Any) {
        currentTxtField = 2
    }
    
    func initSearchController() {
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTicketListVC" {
            if let ticketListVC = segue.destination as? TicketListViewController {
                guard let fromText = fromTextField.text else {
                    return
                }
                guard let toText = toTextField.text else {
                    return
                }
                ticketListVC.dateForTicket = dateTicket
                ticketListVC.fromForTicket = fromText
                ticketListVC.toForTicket = toText
                
            }
        }
    }
}

extension FilterTicketViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        tabalViewSetup()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tag = 18
        tableView.rowHeight = 80
        view.addSubview(tableView)
        tableViewAnimated(load: true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == fromTextField {
            view.endEditing(true)
        }
        return true
    }
    func tabalViewSetup() {
        tableView.frame = CGRect(x: 20, y: view.frame.height, width: view.frame.width - 40, height: view.frame.height - 170)
        tableView.layer.shadowColor = UIColor.darkGray.cgColor
        tableView.layer.shadowOffset = CGSize(width: 2, height: 2)
        tableView.layer.cornerRadius = 10
        tableView.layer.shadowOpacity = 1
        tableView.layer.shadowRadius = 2
        tableView.layer.masksToBounds = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "selectCity")
    }
    
    func tableViewAnimated(load: Bool) {
        if load {
            UIView.animate(withDuration: 0.2) {
                self.tableView.frame = CGRect(x: 10, y: 100, width: self.view.frame.width - 20, height: self.view.frame.height - 100)
            }
        }else {
            UIView.animate(withDuration: 0.2) {
                self.tableView.frame = CGRect(x: 10, y: self.view.frame.height, width: self.view.frame.width - 20, height: self.view.frame.height - 100)
            } completion: { (done) in
                for subView in self.view.subviews {
                    if subView.tag == 18 {
                        subView.removeFromSuperview()
                    }
                }
            }

        }
    }
}

extension FilterTicketViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredCities.count
        }
        return cities.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "selectCity")
        if isFiltering {
            cell.textLabel?.text = filteredCities[indexPath.row]
        }else {
            cell.textLabel?.text = cities[indexPath.row]
        }
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableViewAnimated(load: false)
        if currentTxtField == 1 {
            fromTextField.text = cities[indexPath.row]
        }else {
            toTextField.text = cities[indexPath.row]
        }
        
    }
}

extension FilterTicketViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredCities = cities.filter({ (city:String) -> Bool in
            return city.lowercased().contains(searchText.lowercased()) ?? false
        })
        
        isFiltering = true
        
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isFiltering = false
        searchBar.text = ""
        tableView.reloadData()
    }
    
}

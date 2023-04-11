//
//  FilterTicketViewController.swift
//  BusTicket
//
//  Created by mertcan YAMAN on 5.04.2023.
//

import UIKit
import MapKit

class FilterTicketViewController: UIViewController {

    // MARK: - IBOutlet Definitions
    // TODO: - Test
    // FIXME: - Test 2
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var toTextField: UITextField!
    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var todayBtn: UIButton!
    @IBOutlet weak var tomorrowBtn: UIButton!
    @IBOutlet weak var datePickerField: UIDatePicker!
    
    // MARK: - Variable Definitions
    
    let cities = [ "Adana", "Adıyaman", "Afyon", "Ağrı", "Amasya", "Ankara", "Antalya", "Artvin", "Aydın", "Balıkesir", "Bilecik", "Bingöl", "Bitlis", "Bolu", "Burdur", "Bursa", "Çanakkale", "Çankırı", "Çorum", "Denizli", "Diyarbakır", "Edirne", "Elazığ", "Erzincan", "Erzurum", "Eskişehir", "Gaziantep", "Giresun", "Gümüşhane", "Hakkari", "Hatay", "Isparta", "İçel (Mersin)", "İstanbul", "İzmir", "Kars", "Kastamonu", "Kayseri", "Kırklareli", "Kırşehir", "Kocaeli", "Konya", "Kütahya", "Malatya", "Manisa", "Kahramanmaraş", "Mardin", "Muğla", "Muş", "Nevşehir", "Niğde", "Ordu", "Rize", "Sakarya", "Samsun", "Siirt", "Sinop", "Sivas", "Tekirdağ", "Tokat", "Trabzon", "Tunceli", "Şanlıurfa", "Uşak", "Van", "Yozgat", "Zonguldak", "Aksaray", "Bayburt", "Karaman", "Kırıkkale", "Batman", "Şırnak", "Bartın", "Ardahan", "Iğdır", "Yalova", "Karabük", "Kilis", "Osmaniye", "Düzce"]
    var filteredCities: [String] = []
    var dateTicket: DateTicket = DateTicket()
    var tableView = UITableView()
    var currentTxtField = 0
    var isFiltering = false
    var destinations: [MKPointAnnotation] = []
    var currentRoute: MKRoute?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.shadowColor = .clear
        appearance.backgroundColor = UIColor(red: 45/255, green: 75/255, blue: 115/255, alpha: 1)
        
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        let logOut = UIBarButtonItem(image: #imageLiteral(resourceName: "logout"), style: .plain, target: self, action: #selector(logOut))
        logOut.tintColor = .white
        navigationItem.rightBarButtonItems = [logOut]
        setNeedsStatusBarAppearanceUpdate()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    @IBAction func tomorrowBtnClicked(_ sender: Any) {
        todayBtn.isEnabled = true
        todayBtn.backgroundColor = .clear
        
        tomorrowBtn.isEnabled = false
        tomorrowBtn.backgroundColor = .white
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date())
        datePickerField.date = tomorrow ?? Date()
    }
    @IBAction func todayBtnClicked(_ sender: Any) {
        todayBtn.isEnabled = false
        todayBtn.backgroundColor = .white
        
        tomorrowBtn.isEnabled = true
        tomorrowBtn.backgroundColor = .clear
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
            alertFunc("Cities is empty", "You need to fill the city fields.")
        }
    }
    
    @IBAction func fromTxtChanged(_ sender: Any) {
        if fromTextField.text != "" {
            search(fromTextField.text ?? "")
        }
    }
    @IBAction func toTxtChanged(_ sender: Any) {
        if toTextField.text != "" {
            search(toTextField.text ?? "")
        }
    }
    @IBAction func fromTxtBegin(_ sender: Any) {
        currentTxtField = 1
        searchCancel()
    }
    @IBAction func toTxtBegin(_ sender: Any) {
        currentTxtField = 2
        searchCancel()
    }
    
    @objc func logOut() {
        
    }
    
    /// asdasd
    func search(_ text: String) {
        filteredCities = cities.filter({ (city:String) -> Bool in
            return city.lowercased().contains(text.lowercased()) ?? false
        })
        isFiltering = true
        tableView.reloadData()
    }
    
    func searchCancel() {
        isFiltering = false
        tableView.reloadData()
    }
    func createMapPin() {
        let request = MKLocalSearch.Request()
        if self.mapView.annotations.count == 2 {
            let requestLast = MKLocalSearch.Request()
            request.naturalLanguageQuery = fromTextField.text
            requestLast.naturalLanguageQuery = toTextField.text
            let firstSearch = MKLocalSearch(request: request)
            let lastSearch = MKLocalSearch(request: requestLast)
            activatedSearchRequest(firstSearch,fromTextField.text ?? "")
            activatedSearchRequest(lastSearch,toTextField.text ?? "")
        }else if currentTxtField == 1 {
            request.naturalLanguageQuery = fromTextField.text
            let activeSearch = MKLocalSearch(request: request)
            activatedSearchRequest(activeSearch,fromTextField.text ?? "")
        }else {
            request.naturalLanguageQuery = toTextField.text
            let activeSearch = MKLocalSearch(request: request)
            activatedSearchRequest(activeSearch,toTextField.text ?? "")
        }
    }
    private func activatedSearchRequest(_ request: MKLocalSearch, _ text:String) {
        request.start { response, error in
            if error != nil {
                fatalError("City is nil")
            }else {
                let latitude = response?.boundingRegion.center.latitude
                let longitude = response?.boundingRegion.center.longitude
                
                let annotation = MKPointAnnotation()
                annotation.title = text
                annotation.coordinate = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
                
                if self.mapView.annotations.count == 2 {
                    let allAnnotations = self.mapView.annotations
                    self.mapView.removeAnnotations(allAnnotations)
                    self.destinations.removeAll()
                    self.mapView.removeOverlays(self.mapView.overlays)
                }
                
                self.mapView.addAnnotation(annotation)
                self.destinations.append(annotation)
                
                if self.destinations.count == 2 {
                    self.constructRoute()
                }
                
                let region = MKCoordinateRegion.init(center: annotation.coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
                self.mapView.setRegion(region, animated: true)
            }
        }
    }
    func constructRoute() {
        let directionRequest = MKDirections.Request()
        guard let firstCoordinate = self.destinations.first?.coordinate else { return }
        guard let secondCoordinate = self.destinations.last?.coordinate else { return }
        directionRequest.source = MKMapItem(placemark: MKPlacemark(coordinate: firstCoordinate))
        directionRequest.destination = MKMapItem(placemark: MKPlacemark(coordinate: secondCoordinate))
        directionRequest.transportType = .automobile
        directionRequest.requestsAlternateRoutes = true
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate {[weak self] (response, error) in
            
            guard let strongSelf = self else{ return }
            if error != nil {
                return
            }else if let responseDirection = response, responseDirection.routes.count > 0 {
                strongSelf.currentRoute = responseDirection.routes[0]
                strongSelf.mapView.addOverlay(responseDirection.routes[0].polyline)
                strongSelf.mapView.setVisibleMapRect(responseDirection.routes[0].polyline.boundingMapRect, edgePadding: UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50), animated: true)
            }
        }
    }
    
    func alertFunc(_ title: String, _ content: String) {
        let alert = UIAlertController(title: title, message: content, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true)
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
                self.tableView.frame = CGRect(x: 10, y: 350, width: self.view.frame.width - 20, height: self.view.frame.height - 100)
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
        cell.backgroundColor = UIColor(red: 153.0 / 255.0, green: 180.0 / 255.0, blue: 191.0/255.0, alpha: 0.5)
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
        if currentTxtField == 1 && isFiltering{
            fromTextField.text = filteredCities[indexPath.row]
        }else if currentTxtField == 2 && isFiltering{
            toTextField.text = filteredCities[indexPath.row]
        }else if currentTxtField == 1 && !isFiltering {
            fromTextField.text = cities[indexPath.row]
        }else {
            toTextField.text = cities[indexPath.row]
        }
        createMapPin()
    }
}

extension FilterTicketViewController: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let currentRoute = currentRoute else { return MKOverlayRenderer() }
        let polyLineRenderer = MKPolylineRenderer(polyline: currentRoute.polyline)
        polyLineRenderer.strokeColor = UIColor(red: 191.0 / 255.0, green: 141.0 / 255.0, blue: 48.0/255.0, alpha: 1.0)
        polyLineRenderer.lineWidth = 4
        return polyLineRenderer
    }
}

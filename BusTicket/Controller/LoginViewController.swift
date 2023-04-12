//
//  LoginViewController.swift
//  BusTicket
//
//  Created by mertcan YAMAN on 3.04.2023.
//

import UIKit
import Lottie

class LoginViewController: UIViewController {
    // MARK: - IBOutlet Definitions
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var welcomeAnimationView: LottieAnimationView!
    @IBOutlet weak var logoImageView: UIImageView!
    // MARK: - Variable Definitions
    var users: [String : String] = ["mert1437@gmail.com":"1234567890", "mert14@gmail.com":"123123123", "mert@gmail.com":"12121212",]
    var passengers:  [String : Passenger] = [
        "mert1437@gmail.com": Passenger(id: 36002345772, firstName: "Mertcan", lastName: "Yaman"),
        "mert14@gmail.com": Passenger(id: 46002345773, firstName: "Mert", lastName: "Yaman"),
        "mert@gmail.com": Passenger(id: 56002345774, firstName: "Can", lastName: "Yaman"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        welcomeAnimationView.play()
    }
    // MARK: IBAction methods
    @IBAction func loginBtnClicked(_ sender: Any) {
        // Chack email and password
        guard let password = users[emailTextField.text ?? ""] else {
            alertFunc("Registered email not found")
            return
        }
        // user add to UserDefault
        if passwordTextField.text == password {
            do {
                // Create JSON Encoder
                let encoder = JSONEncoder()

                // Encode Note
                let data = try encoder.encode(passengers[emailTextField.text!])
                UserDefaults().set(data, forKey: "Passenger")
            } catch {
                print("Unable to Encode Note (\(error))")
            }
            performSegue(withIdentifier: "toHomeVCFromLoginVC", sender: nil)
        }else {
            alertFunc("Password is incorrect")
        }
    }
    
    @IBAction func signUpBtnClicked(_ sender: Any) {
        performSegue(withIdentifier: "toSignUpVC", sender: nil)
    }
    
    private func alertFunc(_ content: String) {
        let alert = UIAlertController(title: "Error!", message: content, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
}

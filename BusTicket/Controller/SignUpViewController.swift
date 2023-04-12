//
//  SignUpViewController.swift
//  BusTicket
//
//  Created by mertcan YAMAN on 3.04.2023.
//

import UIKit
import Lottie

class SignUpViewController: UIViewController {
    // MARK: - IBOutlet Definitions
    @IBOutlet weak var tcNoTxtField: UITextField!
    @IBOutlet weak var lastNameTxtField: UITextField!
    @IBOutlet weak var firstNameTxtField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var welcomeAnimationView: LottieAnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        welcomeAnimationView.play()
    }
    // MARK: IBAction methods
    @IBAction func signUpBtnClicked(_ sender: Any) {
        if checkForm() {
            do {
                // Create JSON Encoder
                let encoder = JSONEncoder()

                let id = Int(tcNoTxtField.text!) ?? 0
                let passenger = Passenger(id: id, firstName: firstNameTxtField.text!, lastName: lastNameTxtField.text!)
                // Encode Note
                let data = try encoder.encode(passenger)
                UserDefaults().set(data, forKey: "Passenger")
            } catch {
                print("Unable to Encode Note (\(error))")
            }
            performSegue(withIdentifier: "toHomeVCFromSignupVC", sender: nil)
        }
    }

    @IBAction func loginBtnClicked(_ sender: Any) {
        dismiss(animated: true)
    }
    /// Check Text Fields
    private func checkForm() -> Bool {
        if !invalidEmail() {
            alertFunc("Email is not in the correct format.")
            return false
        }else if !invalidPassword() {
            alertFunc("Password cannot be less than 8 characters")
            return false
        }else if firstNameTxtField.text == "" {
            alertFunc("Name cannot be empty.")
            return false
        }else if lastNameTxtField.text == "" {
            alertFunc("Last name cannot be empty.")
            return false
        }else if tcNoTxtField.text == "" {
            alertFunc("TC no cannot be empty.")
            return false
        }else {
            return true
        }
    }
    /// Check email format
    private func invalidEmail() -> Bool {
        let reqularExpression = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        if !predicate.evaluate(with: emailTextField.text)
        {
            return false
        }
        
        return true
    }
    /// Check password count
    private func invalidPassword() -> Bool {
        guard let password = passwordTextField.text else {
            return false
        }
        if password.count < 8
        {
            return false
        }
        return true
    }
    
    private func alertFunc(_ content: String) {
        let alert = UIAlertController(title: "Error", message: content, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
}

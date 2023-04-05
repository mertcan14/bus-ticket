//
//  SignUpViewController.swift
//  BusTicket
//
//  Created by mertcan YAMAN on 3.04.2023.
//

import UIKit
import Lottie

class SignUpViewController: UIViewController {

    @IBOutlet weak var passwordAgainTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var welcomeAnimationView: LottieAnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signUpBtnClicked(_ sender: Any) {
        if !invalidEmail() {
            alertFunc("Email doğru formatta değil.")
        }else if !invalidPassword() {
            alertFunc("Şifre 8 karakterden az olamaz")
        }else if passwordTextField.text != passwordAgainTextField.text {
            alertFunc("Şifre doğrulaması hatalı.")
        }else {
            performSegue(withIdentifier: "toHomeVCFromSignupVC", sender: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        welcomeAnimationView.play()
    }

    @IBAction func loginBtnClicked(_ sender: Any) {
        dismiss(animated: true)
    }
    
    private func invalidEmail() -> Bool {
        let reqularExpression = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        if !predicate.evaluate(with: emailTextField.text)
        {
            return false
        }
        
        return true
    }
    private func alertFunc(_ content: String) {
        let alert = UIAlertController(title: "Giriş Hatalı", message: content, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
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
}

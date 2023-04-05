//
//  LoginViewController.swift
//  BusTicket
//
//  Created by mertcan YAMAN on 3.04.2023.
//

import UIKit
import Lottie

class LoginViewController: UIViewController {
    var users: [String: String] = ["mert1437@gmail.com":"1234567890", "mert14@gmail.com":"123123123", "mert@gmail.com":"12121212",]

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var welcomeAnimationView: LottieAnimationView!
    @IBOutlet weak var logoImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func loginBtnClicked(_ sender: Any) {
        guard let password = users[emailTextField.text ?? ""] else {
            alertFunc("Kayıtlı email bulunamadı")
            return
        }
        if passwordTextField.text == password {
            performSegue(withIdentifier: "toHomeVCFromLoginVC", sender: nil)
        }else {
            alertFunc("Şifre hatalı")
        }
    }
    
    @IBAction func signUpBtnClicked(_ sender: Any) {
        performSegue(withIdentifier: "toSignUpVC", sender: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        welcomeAnimationView.play()
    }
    
    private func alertFunc(_ content: String) {
        let alert = UIAlertController(title: "Giriş Hatalı", message: content, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
}

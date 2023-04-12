//
//  FormPassengerPopUp.swift
//  BusTicket
//
//  Created by mertcan YAMAN on 10.04.2023.
//

import UIKit
import Lottie

class SuccessPopUp: UIViewController {

    @IBOutlet weak var animationView: LottieAnimationView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var backView: UIView!
    init() {
        super.init(nibName: "FormPassengerPopUp", bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        animationView.play()
    }
    
    func configView() {
        self.view.backgroundColor = .clear
        self.backView.backgroundColor = .black.withAlphaComponent(0.6)
        self.backView.alpha = 0
        self.contentView.alpha = 0
        self.contentView.layer.cornerRadius = 12
    }
    
    func appear(sender: UIViewController) {
        sender.present(self, animated: false) {
            self.show()
        }
    }
    
    func show() {
        UIView.animate(withDuration: 1, delay: 0.1) {
            self.backView.alpha = 1
            self.contentView.alpha = 1
        }
    }
    
    func hide() {
        UIView.animate(withDuration: 1, delay: 0.0, options: .curveEaseOut) {
            self.backView.alpha = 1
            self.contentView.alpha = 1
        } completion: { _ in
            self.dismiss(animated: false)
            self.removeFromParent()
        }
    }
    
    @IBAction func doneBtnClicked(_ sender: Any) {
        hide()
        NotificationCenter.default.post(name: Notification.Name(rawValue: "paymenySuccess"), object: nil)
    }
}

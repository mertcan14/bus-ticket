//
//  UIView+Extension.swift
//  BusTicket
//
//  Created by mertcan YAMAN on 2.04.2023.
//

import UIKit


extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get { return cornerRadius }
        set { self.layer.cornerRadius = newValue }
    }
}

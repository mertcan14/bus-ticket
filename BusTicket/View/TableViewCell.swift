//
//  TableViewCell.swift
//  BusTicket
//
//  Created by mertcan YAMAN on 12.04.2023.
//

import UIKit
import Lottie

class TableViewCell: UITableViewCell {

    @IBOutlet weak var animationView: LottieAnimationView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setUp() {
        animationView.play()
    }
    
}

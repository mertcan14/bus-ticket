//
//  OnboardingCollectionViewCell.swift
//  BusTicket
//
//  Created by mertcan YAMAN on 2.04.2023.
//

import UIKit
import Lottie

class OnboardingCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: OnboardingCollectionViewCell.self)
    
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var animationView: LottieAnimationView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func setup(_ slide: OnboardingSlide) {
        animationView.animation = LottieAnimation.named(slide.image)
        titleLabel.text = slide.title
        contentLabel.text = slide.description
        animationView.loopMode = .loop
        animationView.play()
    }
}

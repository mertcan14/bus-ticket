//
//  OnboardingViewController.swift
//  BusTicket
//
//  Created by mertcan YAMAN on 2.04.2023.
//

import UIKit
import Lottie

class OnboardingViewController: UIViewController {

    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    var slides: [OnboardingSlide] = []
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slides = [
                    OnboardingSlide(title: "Cheapest Price",
                                    description: "Better Ticket offers you the opportunity to query and compare bus tickets of all companies. You can instantly access special discounts and tickets suitable for your budget.", image: "ticket"),
                    OnboardingSlide(title: "Distinguished Companies",
                                    description: "As Better Ticket, we have gathered the most exclusive bus companies for you. On Better Ticket, you can compare bus tickets of all companies, find the bus ticket that suits you and buy it online.", image: "bus"),
                    OnboardingSlide(title: "Transportation to Every Point",
                                    description: "208 Country \n 100.000+ Station \n We present it to our valuable users.", image: "world"),
                ]
        collectionView.contentInsetAdjustmentBehavior = .never
    }
    
    @IBAction func nextBtnClicked(_ sender: Any) {
        if currentPage == slides.count - 1 {
            performSegue(withIdentifier: "toLoginVC", sender: nil)
        } else{
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
        cell.setup(slides[indexPath.row])        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
        pageControl.currentPage = currentPage
    }
}

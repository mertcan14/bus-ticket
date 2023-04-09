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
                    OnboardingSlide(title: "En Rekabetçi Fiyat Garantisi",
                                    description: "Better Ticket size tüm firmaların otobüs biletlerini sorgulama ve karşılaştırma imkanı sunar. Sizlere özel indirimleri ve bütçenize uygun biletleri anında erişebilirsiniz.", image: "ticket"),
                    OnboardingSlide(title: "En Seçkin Firmalar",
                                    description: "Better Ticket olarak en seçkin otobüs firmalarını sizler için bir araya topladık. Tüm firmaların otobüs biletlerini Better Ticket'da karşılaştırabilir, uygun otobüs biletini bulabilir ve online alabilirsiniz.", image: "bus"),
                    OnboardingSlide(title: "Dünyanın Her Noktasına Ulaşım",
                                    description: "208 Ülke \n 100.000+ Durak \n ile siz değerli kullanıcılarmıza sunmaktayız.", image: "world"),
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

//
//  DetailTicketViewController.swift
//  BusTicket
//
//  Created by mertcan YAMAN on 9.04.2023.
//

import UIKit
import Lottie

class DetailTicketViewController: UIViewController {
    
    @IBOutlet weak var ticketsCollectionView: UICollectionView!
    @IBOutlet weak var pageController: UIPageControl!
    
    var ticket: Ticket?
    var currentPage = 0 {
        didSet {
            pageController.currentPage = currentPage
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItems = [done]
        pageController.numberOfPages = ticket?.seatCount ?? 1
    }
    
    @objc func addTapped() {
        performSegue(withIdentifier: "toBackFilterTicketVC", sender: nil)
    }
}

extension DetailTicketViewController: UICollectionViewDelegate, UICollectionViewDataSource,  UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let seatCount = ticket?.seatCount else { return 0 }
        return seatCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "detailTicketCell", for: indexPath) as! DetailTicketCollectionViewCell
        guard let myTicket = ticket else { fatalError("Ticket is nil") }
        cell.setup(myTicket, seatNumber: String(myTicket.seat[indexPath.row]))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
        pageController.currentPage = currentPage
    }
}

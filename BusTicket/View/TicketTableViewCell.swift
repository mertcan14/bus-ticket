//
//  TicketTableViewCell.swift
//  BusTicket
//
//  Created by mertcan YAMAN on 6.04.2023.
//

import UIKit

class TicketTableViewCell: UITableViewCell {

    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var arrivalLabel: UILabel!
    @IBOutlet weak var depatureLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setup(_ busInfo: BusInfo) {
        priceLabel.text = busInfo.price
        timeLabel.text = busInfo.time
        arrivalLabel.text = busInfo.arrivalTime
        depatureLabel.text = busInfo.depatureTime
        contentLabel.text = busInfo.content
        titleLabel.text = busInfo.brand
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8))
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

//
//  ExampleSeatConfig.swift
//  BusTicket
//
//  Created by mertcan YAMAN on 6.04.2023.
//

import ALBusSeatView

class ExampleSeatConfig: ALBusSeatViewConfig {
    override init() {
        super.init()
        seatSelectedBGColor = UIColor(red: 21.0 / 255.0, green: 202.0 / 255.0, blue: 128.0 / 255.0, alpha: 1.0)
        seatSoldWomanBGColor = UIColor(red: 1.0, green: 95.0 / 255.0, blue: 95.0 / 255.0, alpha: 1.0)
        seatSoldManBGColor = UIColor(red: 61.0 / 255.0, green: 145.0 / 255.0, blue: 1.0, alpha: 1.0)
        seatShadowColor = UIColor(red: 146.0 / 255.0, green: 184.0 / 255.0, blue: 202.0 / 255.0, alpha: 0.5)
        busFrontImage = UIImage(named: "bus-front-view")
        busFrontImageWidth = 120
        floorSeperatorImage = UIImage(named: "bus-docker-front-view")
        seatRemoveImage = UIImage(named: "iconRemoveButton")
        floorSeperatorWidth = 60
        centerHallInfoText = "Swipe!"
        centerHallHeight = 40
        tooltipText = "Select Gender"
        seatNumberSelectedFont = UIFont(name: "Futura", size: 28.0)!
    }
}

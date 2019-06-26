//
//  CircleSpreadButtonView.swift
//  CircleSpreadButton
//
//  Created by kawaharadai on 2019/06/26.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit

class CircleSpreadButtonView: UIView {

    let centerButtonInfo: CircleSpreadButtonInfo
    var spreadButtonInfo = [CircleSpreadButtonInfo]()

    init(origin: CGPoint = .zero, viewLength: CGFloat = 100, centerButtonInfo: CircleSpreadButtonInfo, spreadButtonInfo: [CircleSpreadButtonInfo]) {
        self.centerButtonInfo = centerButtonInfo
        self.spreadButtonInfo = spreadButtonInfo
        super.init(frame: CGRect(origin: origin, size: CGSize(width: viewLength, height: viewLength)))
        setupSpreadButton()
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.width / 2
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSpreadButton() {
        spreadButtonInfo.enumerated().forEach { [weak self] (index, buttonInfo) in
            guard let self = self else { return }
            let spreadButton = UIButton(frame: CGRect(x: 0, y: 0,
                                                width: self.frame.width * 0.8,
                                                height: self.frame.height * 0.8))
            spreadButton.center = self.center
            spreadButton.backgroundColor = buttonInfo.color
            spreadButton.setTitle(buttonInfo.title, for: .normal)
            // TODO: タップイベントの付与方法検討
            self.addSubview(spreadButton)
            spreadButton.layer.masksToBounds = true
            spreadButton.layer.cornerRadius = spreadButton.frame.width / 2
        }

        setupCenterButton()
    }

    private func setupCenterButton() {
        let centerButton = UIButton(frame: CGRect(origin: .zero, size: self.frame.size))
        centerButton.backgroundColor = centerButtonInfo.color
        centerButton.setTitle(centerButtonInfo.title, for: .normal)
        centerButton.addTarget(self, action: #selector(spreadAnimation), for: UIControl.Event.touchUpInside)
        self.addSubview(centerButton)
        centerButton.layer.masksToBounds = true
        centerButton.layer.cornerRadius = centerButton.frame.width / 2
    }

    @objc private func spreadAnimation() {
        print("tapped")
    }

    private func circumferenceCoordinate(degree: Double, radius: CGFloat) -> CGPoint {
        let θ = Double.pi / Double(-180) * Double(degree)
        let x = Double(radius) * cos(θ)
        let y = Double(radius) * sin(θ)
        return CGPoint(x: x, y: y)
    }
}

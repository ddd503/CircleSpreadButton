//
//  CircleSpreadButtonView.swift
//  CircleSpreadButton
//
//  Created by kawaharadai on 2019/06/26.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit

class CircleSpreadButtonView: UIView {
    // Initiarize
    private let origin: CGPoint
    private let viewSize: CGSize
    private let centerButtonInfo: CenterButtonInfo
    private let spreadButtonInfo: [SpreadButtonInfo]
    private let firstSpreadButtonCenterAngle: Double
    private let spreadButtonAngleInterval: Double

    // Private
    private let spreadViewSizeParcentage: CGFloat = 3.0
    private let spreadButtonSizeParcentage: CGFloat = 0.7
    private (set) var isOpen = false

    init(origin: CGPoint, length: CGFloat = 80,
         firstSpreadButtonCenterAngle: Double = 100, spreadButtonAngleInterval: Double = 40,
         centerButtonInfo: CenterButtonInfo, spreadButtonInfo: [SpreadButtonInfo]) {
        self.origin = origin
        viewSize = CGSize(width: length, height: length)
        self.centerButtonInfo = centerButtonInfo
        self.spreadButtonInfo = spreadButtonInfo
        self.firstSpreadButtonCenterAngle = firstSpreadButtonCenterAngle
        self.spreadButtonAngleInterval = spreadButtonAngleInterval
        super.init(frame: CGRect(origin: origin, size: viewSize))
        roundCorner(view: self)
        setupSpreadButton()
        setupCenterButton()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupCenterButton() {
        let button = UIButton(frame: CGRect(origin: .zero, size: viewSize))
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(centerButtonAction(sender:)), for: .touchUpInside)
        addSubview(button)
        roundCorner(view: button)
    }

    func setupSpreadButton() {
        spreadButtonInfo.enumerated().forEach { [weak self] (index, buttonInfo) in
            guard let self = self else { return }
            let spreadButton = UIButton(frame: CGRect(origin: .zero,
                                                      size: CGSize(width: self.viewSize.width * self.spreadButtonSizeParcentage,
                                                                   height: self.viewSize.height * self.spreadButtonSizeParcentage)))
            spreadButton.center = self.roundViewCenter(length: self.viewSize.width)
            spreadButton.backgroundColor = buttonInfo.color
            spreadButton.setTitle(buttonInfo.title, for: .normal)
            spreadButton.tag = index + 1
            spreadButton.addTarget(self, action: #selector(spreadButtonAction(sender:)), for: .touchUpInside)
            self.addSubview(spreadButton)
            self.roundCorner(view: spreadButton)
        }
    }

    @objc func centerButtonAction(sender: UIButton) {
        sender.isEnabled = false

        var buttonPairs = [(button: UIButton, center: CGPoint)]()
        let spreadViewSize = isOpen ? viewSize : CGSize(width: viewSize.width * spreadViewSizeParcentage,
                                                        height: viewSize.height * spreadViewSizeParcentage)
        let spreadViewCenterBeforeTransform = center
        let centerButtonCenter = CGPoint(x: spreadViewSize.width / 2, y: spreadViewSize.height / 2)
        let spreadViewCenterAfterTransform = self.roundViewCenter(length: spreadViewSize.width)

        spreadButtonInfo.enumerated().forEach { [weak self] (index, buttonInfo) in
            guard let self = self, let spreadButton = self.viewWithTag(index + 1) as? UIButton else {
                sender.isEnabled = true
                return
            }
            let degree = firstSpreadButtonCenterAngle + (spreadButtonAngleInterval * Double(index))
            let circumferencePoint = self.convert(self.circumferenceCoordinate(degree: degree,
                                                                               radius: (spreadViewSize.width / 2) - (spreadButton.frame.width * 0.6)), to: self)
            let spreadButtonCenter = CGPoint(x: self.isOpen ? spreadViewCenterAfterTransform.x : spreadViewCenterAfterTransform.x + circumferencePoint.x,
                                             y: self.isOpen ? spreadViewCenterAfterTransform.y : spreadViewCenterAfterTransform.y + circumferencePoint.y)
            buttonPairs.append((spreadButton, spreadButtonCenter))
        }

        let animation = { [weak self] () -> () in
            guard let self = self else { return }
            self.frame.size = spreadViewSize
            self.center = spreadViewCenterBeforeTransform
            self.roundCorner(view: self)
            sender.center = centerButtonCenter
            buttonPairs.forEach({ (button, center) in
                button.center = center
            })
        }

        let animator = self.isOpen ?
            UIViewPropertyAnimator(duration: 0.1, curve: .linear, animations: {
                animation()
            })
            :
            UIViewPropertyAnimator(duration: 0.7, dampingRatio: 0.5) {
                animation()
        }

        animator.addCompletion { [weak self] (_) in
            self?.isOpen.toggle()
            sender.isEnabled = true
        }

        animator.startAnimation()
    }

    @objc func spreadButtonAction(sender: UIButton) {
        guard spreadButtonInfo.count >= sender.tag else { return }
        spreadButtonInfo[sender.tag - 1].task()
    }

    func roundCorner(view: UIView, length: CGFloat? = nil) {
        view.layer.masksToBounds = true
        view.layer.cornerRadius = (length ?? view.frame.width) / 2
    }

    func roundViewCenter(length: CGFloat) -> CGPoint {
        return CGPoint(x: length / 2, y: length / 2)
    }

    func circumferenceCoordinate(degree: Double, radius: CGFloat) -> CGPoint {
        let θ = Double.pi / Double(-180) * Double(degree)
        let x = Double(radius) * cos(θ)
        let y = Double(radius) * sin(θ)
        return CGPoint(x: x, y: y)
    }
}

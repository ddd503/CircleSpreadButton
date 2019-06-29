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
    private let spreadButtonInfoArray: [SpreadButtonInfo]
    private let firstSpreadButtonCenterAngle: Double
    private let spreadButtonAngleInterval: Double

    // Private
    private let spreadViewSizeParcentage: CGFloat = 3.5
    private let spreadButtonSizeParcentage: CGFloat = 0.7
    private (set) var isOpen = false

    init(origin: CGPoint, length: CGFloat = 80,
         firstSpreadButtonCenterAngle: Double = 100, spreadButtonAngleInterval: Double = 40,
         centerButtonInfo: CenterButtonInfo, spreadButtonInfoArray: [SpreadButtonInfo]) {
        self.origin = origin
        viewSize = CGSize(width: length, height: length)
        self.centerButtonInfo = centerButtonInfo
        self.spreadButtonInfoArray = spreadButtonInfoArray
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

    private func setupCenterButton() {
        let centerButton = UIButton(frame: CGRect(origin: .zero, size: viewSize))
        centerButton.setBackgroundImage(centerButtonInfo.type?.backgroundImage ?? centerButtonInfo.backgroundImage,
                                        for: .normal)
        centerButton.backgroundColor = centerButtonInfo.type?.backgroundColor ?? centerButtonInfo.backgroundColor
        centerButton.setTitle(centerButtonInfo.type?.title ?? centerButtonInfo.title, for: .normal)
        centerButton.setTitleColor(.white, for: .normal)
        centerButton.setTitleColor(UIColor.white.withAlphaComponent(0.5), for: .highlighted)
        centerButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        centerButton.addTarget(self, action: #selector(centerButtonAction(sender:)), for: .touchUpInside)
        addSubview(centerButton)
        roundCorner(view: centerButton)
    }

    private func setupSpreadButton() {
        spreadButtonInfoArray.enumerated().forEach { [weak self] (index, spreadButtonInfo) in
            guard let self = self else { return }
            let spreadButton = UIButton(frame: CGRect(origin: .zero,
                                                      size: CGSize(width: self.viewSize.width * self.spreadButtonSizeParcentage,
                                                                   height: self.viewSize.height * self.spreadButtonSizeParcentage)))
            spreadButton.setBackgroundImage(spreadButtonInfo.type?.backgroundImage ?? spreadButtonInfo.backgroundImage,
                                            for: .normal)
            spreadButton.center = self.roundViewCenter(length: self.viewSize.width)
            spreadButton.backgroundColor = spreadButtonInfo.type?.backgroundColor ?? spreadButtonInfo.backgroundColor
            spreadButton.setTitle(spreadButtonInfo.type?.title ?? spreadButtonInfo.title, for: .normal)
            spreadButton.setTitleColor(.white, for: .normal)
            spreadButton.setTitleColor(UIColor.white.withAlphaComponent(0.5), for: .highlighted)
            spreadButton.titleLabel?.lineBreakMode = .byTruncatingTail
            spreadButton.tag = index + 1
            spreadButton.addTarget(self, action: #selector(spreadButtonAction(sender:)), for: .touchUpInside)
            self.addSubview(spreadButton)
            self.roundCorner(view: spreadButton)
        }
    }

    @objc private func centerButtonAction(sender: UIButton) {
        sender.isEnabled = false

        var buttonPairs = [(button: UIButton, center: CGPoint)]()
        let spreadViewSize = isOpen ? viewSize : CGSize(width: viewSize.width * spreadViewSizeParcentage,
                                                        height: viewSize.height * spreadViewSizeParcentage)
        let spreadViewCenterBeforeTransform = center
        let centerButtonCenter = CGPoint(x: spreadViewSize.width / 2, y: spreadViewSize.height / 2)
        let spreadViewCenterAfterTransform = self.roundViewCenter(length: spreadViewSize.width)

        spreadButtonInfoArray.enumerated().forEach { [weak self] (index, _) in
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

    @objc private func spreadButtonAction(sender: UIButton) {
        guard spreadButtonInfoArray.count >= sender.tag else { return }
        scalingAnimation(view: sender)
        spreadButtonInfoArray[sender.tag - 1].task()
    }

    private func scalingAnimation(view: UIView) {
        let transform = CGAffineTransform(scaleX: 1.4, y: 1.4)

        let animator = UIViewPropertyAnimator(duration: 0.2, curve: .linear) {
            view.transform = transform
        }

        animator.addAnimations({
            view.transform = .identity
        }, delayFactor: 0.5)

        animator.startAnimation()
    }

    private func roundCorner(view: UIView, length: CGFloat? = nil) {
        view.layer.masksToBounds = true
        view.layer.cornerRadius = (length ?? view.frame.width) / 2
    }

    private func roundViewCenter(length: CGFloat) -> CGPoint {
        return CGPoint(x: length / 2, y: length / 2)
    }

    private func circumferenceCoordinate(degree: Double, radius: CGFloat) -> CGPoint {
        let θ = Double.pi / Double(-180) * Double(degree)
        let x = Double(radius) * cos(θ)
        let y = Double(radius) * sin(θ)
        return CGPoint(x: x, y: y)
    }
}

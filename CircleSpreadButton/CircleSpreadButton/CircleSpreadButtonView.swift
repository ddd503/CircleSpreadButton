//
//  CircleSpreadButtonView.swift
//  CircleSpreadButton
//
//  Created by kawaharadai on 2019/06/26.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit

class CircleSpreadButtonView: UIView {

    private let centerButtonInfo: CircleSpreadButtonInfo
    private var spreadButtonInfo = [CircleSpreadButtonInfo]()

    private let spreadButtonSizeParcentage: CGFloat = 0.7
    private var isOpen = false

    init(origin: CGPoint = .zero, viewLength: CGFloat = 80, centerButtonInfo: CircleSpreadButtonInfo, spreadButtonInfo: [CircleSpreadButtonInfo]) {
        self.centerButtonInfo = centerButtonInfo
        self.spreadButtonInfo = spreadButtonInfo
        super.init(frame: CGRect(origin: origin, size: CGSize(width: viewLength, height: viewLength)))
        setupSpreadButton()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSpreadButton() {
        spreadButtonInfo.enumerated().forEach { [weak self] (index, buttonInfo) in
            guard let self = self else { return }
            let spreadButton = UIButton(frame: CGRect(x: 0, y: 0,
                                                width: self.frame.width * spreadButtonSizeParcentage,
                                                height: self.frame.height * spreadButtonSizeParcentage))
            spreadButton.center = self.center
            spreadButton.backgroundColor = buttonInfo.color
            spreadButton.setTitle(buttonInfo.title, for: .normal)
            spreadButton.tag = index + 1
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
        centerButton.addTarget(self, action: #selector(spreadAnimation(sender:)), for: .touchUpInside)
        self.addSubview(centerButton)
        centerButton.layer.masksToBounds = true
        centerButton.layer.cornerRadius = centerButton.frame.width / 2
    }

    @objc private func spreadAnimation(sender: UIButton) {
        sender.isEnabled = false

        var buttonPairs = [(button: UIButton, transform: CGAffineTransform)]()

        spreadButtonInfo.enumerated().forEach { [weak self] (index, buttonInfo) in
            guard let self = self, let spreadButton = self.viewWithTag(index + 1) as? UIButton else {
                sender.isEnabled = true
                return
            }
            let center = self.isOpen ? .zero : self.circumferenceCoordinate(degree: Double(100 + (35 * index)), radius: self.frame.width * 1.3)
            let transform = CGAffineTransform(translationX: center.x, y: center.y)
            buttonPairs.append((spreadButton, transform))
        }

        let animator = self.isOpen ?
            UIViewPropertyAnimator(duration: 0.1, curve: .linear) {
                buttonPairs.forEach({ (button, _) in
                    button.transform = .identity
                })
            } :
            UIViewPropertyAnimator(duration: 0.4, dampingRatio: 0.5) {
                buttonPairs.forEach({ (button, transform) in
                    button.transform = transform
                })
        }

        animator.addCompletion { [weak self] _ in
            sender.isEnabled = true
            self?.isOpen.toggle()
        }

        animator.startAnimation()
    }

    private func circumferenceCoordinate(degree: Double, radius: CGFloat) -> CGPoint {
        let θ = Double.pi / Double(-180) * Double(degree)
        let x = Double(radius) * cos(θ)
        let y = Double(radius) * sin(θ)
        return CGPoint(x: x, y: y)
    }
}

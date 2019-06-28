//
//  TestView.swift
//  CircleSpreadButton
//
//  Created by kawaharadai on 2019/06/28.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit

class TestView: UIView {

    let viewSize: CGSize
    let centerButtonInfo: CenterButtonInfo
    var spreadButtonInfo: [SpreadButtonInfo] = []
    let spreadButtonSizeParcentage: CGFloat = 0.7
    var isOpen = false

    init(origin: CGPoint, length: CGFloat,
         centerButtonInfo: CenterButtonInfo, spreadButtonInfo: [SpreadButtonInfo]) {
        viewSize = CGSize(width: length, height: length)
        self.centerButtonInfo = centerButtonInfo
        self.spreadButtonInfo = spreadButtonInfo
        super.init(frame: CGRect(origin: origin, size: viewSize))
        backgroundColor = .red
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

        let spreadViewSize = isOpen ? viewSize : CGSize(width: viewSize.width * 3.0, height: viewSize.height * 3.0)
        let spreadViewCenter = center
        let centerButtonCenter = CGPoint(x: spreadViewSize.width / 2, y: spreadViewSize.height / 2)

        let animator = UIViewPropertyAnimator(duration: 1.0, dampingRatio: 0.5) {
            self.frame.size = spreadViewSize
            self.center = spreadViewCenter
            self.roundCorner(view: self)
            sender.center = centerButtonCenter
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
}

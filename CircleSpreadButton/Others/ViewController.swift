//
//  ViewController.swift
//  CircleSpreadButton
//
//  Created by kawaharadai on 2019/06/26.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let spreadButtonInfo1 = SpreadButtonInfo(color: .red, title: "赤", task: {
            print("red")
        })

        let spreadButtonInfo2 = SpreadButtonInfo(color: .blue, title: "青", task: {
            print("blue")
        })

        let spreadButtonInfo3 = SpreadButtonInfo(color: .brown, title: "茶", task: {
            print("brown")
        })

        let centerButtonInfo = CenterButtonInfo(color: .gray, title: "Tap")

        let length: CGFloat = 80
        let origin = CGPoint(x: (view.frame.width / 2) - (length / 2), y: view.frame.height / 2 - (length / 2))
        let circleSpreadButtonView = CircleSpreadButtonView(origin: origin, length: length,
                                                            centerButtonInfo: centerButtonInfo,
                                                            spreadButtonInfo: [spreadButtonInfo1, spreadButtonInfo2, spreadButtonInfo3])
        view.addSubview(circleSpreadButtonView)
    }

}


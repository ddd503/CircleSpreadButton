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

        let spreadButtonInfo4 = SpreadButtonInfo(color: .magenta, title: "マゼンタ", backgroundImage: UIImage(named: "camera"), task: {
            print("マゼンタ")
        })

        let centerButtonInfo = CenterButtonInfo(color: .gray, title: "Tap", backgroundImage: UIImage(named: "camera"))

        let length: CGFloat = 80
        let origin = CGPoint(x: (view.frame.width / 2) - (length / 2), y: view.frame.height / 2 - (length / 2))
        let circleSpreadButtonView = CircleSpreadButtonView(origin: origin, length: length,
                                                            centerButtonInfo: centerButtonInfo,
                                                            spreadButtonInfo: [spreadButtonInfo1, spreadButtonInfo2, spreadButtonInfo3, spreadButtonInfo4])
        view.addSubview(circleSpreadButtonView)
    }

}


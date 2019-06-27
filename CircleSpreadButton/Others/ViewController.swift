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

        let circleView = CircleSpreadButtonView(parentView: view,
                                                center: CGPoint(x: view.center.x * 1.7, y: view.center.y * 1.7),
                                                centerButtonInfo: centerButtonInfo,
                                                spreadButtonInfo: [spreadButtonInfo1,
                                                                   spreadButtonInfo2,
                                                                   spreadButtonInfo3])
        view.addSubview(circleView)
    }

}


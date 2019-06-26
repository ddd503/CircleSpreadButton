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
        let info1 = CircleSpreadButtonInfo(color: .red, title: "赤")
        let info2 = CircleSpreadButtonInfo(color: .blue, title: "青")
        let centerInfo = CircleSpreadButtonInfo(color: .orange, title: "Tap")

        let circleView = CircleSpreadButtonView(centerButtonInfo: centerInfo, spreadButtonInfo: [info1, info2])
        circleView.center = self.view.center
        self.view.addSubview(circleView)
    }

}


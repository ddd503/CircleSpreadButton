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

        let centerButtonInfo = CenterButtonInfo(title: "Tap", backgroundColor: .orange)

        let cameraButtonInfo = SpreadButtonInfo(type: .camera, task: {
            print("パシャり")
        })
        let libraryButtonInfo = SpreadButtonInfo(type: .library, task: {
            print("ひらり")
        })

        let length: CGFloat = 80
        let origin = CGPoint(x: (view.frame.width / 2) - (length / 2), y: view.frame.height / 2 - (length / 2))
        let circleSpreadButtonView = CircleSpreadButtonView(origin: origin, length: length,
                                                            centerButtonInfo: centerButtonInfo,
                                                            spreadButtonInfoArray: [cameraButtonInfo, libraryButtonInfo])
        view.addSubview(circleSpreadButtonView)
    }

}


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

        // センターのボタン作成
        let centerButtonInfo = CenterButtonInfo(title: "Tap", backgroundColor: .black)

        // デフォルトボタン使用時
        let c = SpreadButtonInfo(type: .camera, task: {
            print("パシャり")
        })
        let l = SpreadButtonInfo(type: .library, task: {
            print("ひらり")
        })
        let w = SpreadButtonInfo(type: .write, task: {
            print("カキカキ")
        })

        // カスタムボタン使用時
        let b1 = SpreadButtonInfo(title: "😆", backgroundColor: .red, backgroundImage: nil, type: nil, task: {
            self.view.backgroundColor = .red
        })
        let b2 = SpreadButtonInfo(title: "😃", backgroundColor: .blue, backgroundImage: nil, type: nil, task: {
            self.view.backgroundColor = .blue
        })
        let b3 = SpreadButtonInfo(title: "😌", backgroundColor: .green, backgroundImage: nil, type: nil, task: {
            self.view.backgroundColor = .green
        })
        let b4 = SpreadButtonInfo(title: "😝", backgroundColor: .cyan, backgroundImage: nil, type: nil, task: {
            self.view.backgroundColor = .cyan
        })
        let b5 = SpreadButtonInfo(title: "😍", backgroundColor: .purple, backgroundImage: nil, type: nil, task: {
            self.view.backgroundColor = .purple
        })
        let b6 = SpreadButtonInfo(title: "😀", backgroundColor: .orange, backgroundImage: nil, type: nil, task: {
            self.view.backgroundColor = .orange
        })
        let b7 = SpreadButtonInfo(title: "🤓", backgroundColor: .brown, backgroundImage: nil, type: nil, task: {
            self.view.backgroundColor = .brown
        })
        let b8 = SpreadButtonInfo(title: "😁", backgroundColor: .magenta, backgroundImage: nil, type: nil, task: {
            self.view.backgroundColor = .magenta
        })
        let b9 = SpreadButtonInfo(title: "😊", backgroundColor: .yellow, backgroundImage: nil, type: nil, task: {
            self.view.backgroundColor = .yellow
        })

        let spreadButtonInfoArray = [b1, b2, b3, b4, b5, b6, b7, b8, b9]

        let length: CGFloat = 80
        let origin = CGPoint(x: (view.frame.width / 2) - (length / 2), y: view.frame.height / 2 - (length / 2))
        let origin2 = CGPoint(x: view.frame.width * 0.7, y: view.frame.height * 0.8)

        let circleSpreadButtonView = CircleSpreadButtonView(origin: origin, length: length,
                                                            centerButtonInfo: centerButtonInfo,
                                                            spreadButtonInfoArray: spreadButtonInfoArray)
        view.addSubview(circleSpreadButtonView)
    }

}


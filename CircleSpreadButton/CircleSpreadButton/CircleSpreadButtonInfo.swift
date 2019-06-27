//
//  CircleSpreadButtonInfo.swift
//  CircleSpreadButton
//
//  Created by kawaharadai on 2019/06/26.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit

struct CenterButtonInfo {
    let color: UIColor
    let title: String

    init(color: UIColor = .white, title: String = "") {
        self.color = color
        self.title = title
    }
}

struct SpreadButtonInfo {
    let color: UIColor
    let title: String
    let task: () -> ()

    init(color: UIColor = .white, title: String = "", task: @escaping () -> ()) {
        self.color = color
        self.title = title
        self.task = task
    }
}

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
    let backgroundImage: UIImage?

    init(color: UIColor = .white, title: String = "", backgroundImage: UIImage? = nil) {
        self.color = color
        self.title = title
        self.backgroundImage = backgroundImage
    }
}

struct SpreadButtonInfo {
    let color: UIColor
    let title: String
    let backgroundImage: UIImage?
    let task: () -> ()

    init(color: UIColor = .white, title: String = "", backgroundImage: UIImage? = nil, task: @escaping () -> ()) {
        self.color = color
        self.title = title
        self.backgroundImage = backgroundImage
        self.task = task
    }
}

//
//  CircleSpreadButtonInfo.swift
//  CircleSpreadButton
//
//  Created by kawaharadai on 2019/06/26.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit

struct CenterButtonInfo {
    let title: String
    let backgroundColor: UIColor
    let backgroundImage: UIImage?
    let type: CircleSpreadButtonType?

    init(title: String = "", backgroundColor: UIColor = .white, backgroundImage: UIImage? = nil, type: CircleSpreadButtonType? = nil) {
        self.title = title
        self.backgroundColor = backgroundColor
        self.backgroundImage = backgroundImage
        self.type = type
    }
}

struct SpreadButtonInfo {
    let title: String
    let backgroundColor: UIColor
    let backgroundImage: UIImage?
    let type: CircleSpreadButtonType?
    let task: () -> ()

    init(title: String = "", backgroundColor: UIColor = .white, backgroundImage: UIImage? = nil, type: CircleSpreadButtonType? = nil, task: @escaping () -> ()) {
        self.title = title
        self.backgroundColor = backgroundColor
        self.backgroundImage = backgroundImage
        self.type = type
        self.task = task
    }
}

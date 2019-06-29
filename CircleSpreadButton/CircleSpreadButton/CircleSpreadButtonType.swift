//
//  CircleSpreadButtonType.swift
//  CircleSpreadButton
//
//  Created by kawaharadai on 2019/06/29.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit

enum CircleSpreadButtonType {
    case camera
    case library
    case write

    var title: String {
        return ""
    }

    var backgroundColor: UIColor {
        return .black
    }

    var backgroundImage: UIImage {
        switch self {
        case .camera:
            return UIImage(named: "camera")!
        case .library:
            return UIImage(named: "library")!
        case .write:
            return UIImage(named: "write")!
        }
    }
}

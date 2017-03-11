//
// Created by Paolo Tagliani on 11/03/2017.
// Copyright (c) 2017 Pablosproject. All rights reserved.
//

import Foundation
import UIKit

enum TextStyle {
    case interviewListTitle
    case interviewListDetail
    case interviewListDate


    func font() -> UIFont {
        switch self {
        case .interviewListTitle:
            return UIFont.boldSystemFont(ofSize: 25)
        case .interviewListDetail:
            return UIFont.systemFont(ofSize: 15)
		case .interviewListDate:
             return UIFont.systemFont(ofSize: 12)
        }
    }

    func color() -> UIColor {
        switch self {
        case .interviewListTitle:
            return UIColor.black
		case .interviewListDetail:
            return UIColor(red: 136.0 / 255.0, green: 136.0 / 255.0, blue: 136.0 / 255.0, alpha: 1)
        case .interviewListDate:
            return UIColor(red: 170.0 / 255.0, green: 170.0 / 255.0, blue: 170.0 / 255.0, alpha: 1)
        }
    }

}

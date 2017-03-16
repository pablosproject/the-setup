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

    case interviewH1
    case interviewH2
    case interviewH3
	case interviewH4
	case interviewBody


    func font() -> UIFont {
        switch self {
        case .interviewListTitle:
            return UIFont(name: "Roboto-Bold", size: 25)!
        case .interviewListDetail:
            return UIFont(name: "Roboto-Regular", size: 15)!
        case .interviewListDate:
            return UIFont(name: "Roboto-Regular", size: 12)!
		case .interviewH1:
			return UIFont(name: "Roboto-Bold", size: 27)!
		case .interviewH2:
			return UIFont(name: "Roboto-Bold", size: 26)!
		case .interviewH3:
			return UIFont(name: "Roboto-Bold", size: 25)!
		case .interviewH4:
			return UIFont(name: "Roboto-Bold", size: 24)!
		case .interviewBody:
			return UIFont(name: "Roboto-Regular", size: 16)!
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
		case .interviewH1:
			return UIColor.black
		case .interviewH2:
			return UIColor(red: 254.0 / 255.0, green: 46.0 / 255.0, blue: 154.0 / 255.0, alpha: 1)
		case .interviewH3:
			return UIColor.black
		case .interviewH4:
			return UIColor.black
		case .interviewBody:
			return UIColor.black
        }
    }

}

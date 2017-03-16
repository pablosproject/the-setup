//
// Created by Paolo Tagliani on 14/03/2017.
// Copyright (c) 2017 Pablosproject. All rights reserved.
//

import Foundation

extension Date {
    static func ts_dateFormatter() ->DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy"
        return dateFormatter
    }
}

//
//  Interview.swift
//  TheSetup
//
//  Created by Paolo Tagliani on 17/02/2017.
//  Copyright © 2017 Pablosproject. All rights reserved.
//

import Foundation
import ObjectMapper

class Interview: Mappable {
    public private(set) var slug: String?
    public private(set) var name: String?
    public private(set) var url: URL?
    public private(set) var summary: String?
    public private(set) var date: TimeInterval?
    public private(set) var categories: [String]?

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        slug <- map["slug"]
        name <- map["name"]
        url <- (map["url"],URLTransform())
        summary <- map["summary"]
        date <- map["date"]
        categories <- map["categories"]
    }
}

class CompleteInterview: Interview {
    public private(set) var contents: String?
    public private(set) var hardware: [Gear]?
    public private(set) var software: [Gear]?

    required init?(map: Map) {
        super.init(map: map)
    }

    override func mapping(map: Map) {
        super.mapping(map: map)

        contents <- map["contents"]
        hardware <- map["gear.hardware"]
        software <- map["gear.software"]
    }
}


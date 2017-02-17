//
//  Gear.swift
//  TheSetup
//
//  Created by Paolo Tagliani on 17/02/2017.
//  Copyright © 2017 Pablosproject. All rights reserved.
//

import Foundation
import ObjectMapper

class Gear: Mappable {
    public private(set) var slug: String?
    public private(set) var name: String?
    public private(set) var url: URL?
    public private(set) var description: String?

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        slug <- map["slug"]
        name <- map["name"]
        url <- map["url"]
        description <- map["description"]
    }
}

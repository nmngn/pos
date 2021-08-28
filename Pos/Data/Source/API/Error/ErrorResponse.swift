//
//  ErrorResponse.swift
//  Pos
//
//  Created by Nam Ngây on 28/08/2021.
//

import Foundation
import ObjectMapper

struct ErrorResponse: Mappable {
    
    var name: String = ""
    var message: String = ""
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    mutating func mapping(map: Map) {
        name <- map["name"]
        message <- map["message"]
    }
}

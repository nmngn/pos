//
//  BaseResult.swift
//  Pos
//
//  Created by Nam Ngây on 28/08/2021.
//

import Foundation
import ObjectMapper

enum BaseResult<T: Mappable> {
    case success(T?)
    case failure(error: BaseError?)
}

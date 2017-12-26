//
//  Item.swift
//  Get 'er done
//
//  Created by Edwin Ruiz on 12/25/17.
//  Copyright © 2017 Edwin Ruiz. All rights reserved.
//

import Foundation
            // Encodable, Decodable  can be replaced with Codable
class Item: Codable {
    var title : String = ""
    var done : Bool = false
}

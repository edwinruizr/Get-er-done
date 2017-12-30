//
//  Category.swift
//  Get er done
//
//  Created by Edwin Ruiz on 12/28/17.
//  Copyright © 2017 Edwin Ruiz. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var color: String = ""
    // category has a list of items
    let items = List<Item>()
}

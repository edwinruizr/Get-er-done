//
//  Item.swift
//  Get er done
//
//  Created by Edwin Ruiz on 12/28/17.
//  Copyright © 2017 Edwin Ruiz. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}

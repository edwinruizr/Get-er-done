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
    let items = List<Item>()
}

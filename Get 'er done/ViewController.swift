//
//  ViewController.swift
//  Get 'er done
//
//  Created by Edwin Ruiz on 12/24/17.
//  Copyright © 2017 Edwin Ruiz. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    let itemArray = ["Learn", "Stay consistent", "be awesome"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    // MARK - Tableview datasource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
}


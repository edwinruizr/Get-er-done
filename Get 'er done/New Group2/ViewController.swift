//
//  ViewController.swift
//  Get 'er done
//
//  Created by Edwin Ruiz on 12/24/17.
//  Copyright © 2017 Edwin Ruiz. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        if let items = defaults.array(forKey: "listArray") as? [String] {
//            itemArray = items
//        }
        let newItem = Item()
        newItem.title = "Learn"
        itemArray.append(newItem)
        let newItem2 = Item()
        newItem2.title = "Persist"
        itemArray.append(newItem2)
        let newItem3 = Item()
        newItem3.title = "Focus"
        itemArray.append(newItem3)
    }

    // MARK - Tableview datasource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        return cell
    }
    
    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        // don't highlight the row selected 
        tableView.deselectRow(at: indexPath, animated: true)
        self.saveData()
    }
    
    //MARK - Add new items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            // what happens after the user hits the add item button
            //print(textField.text!)
            
            let item = Item()
            item.title = textField.text!
            // add new item to our array
            self.itemArray.append(item)
           
            self.saveData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func saveData(){
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        }catch{
            print("Could not encode item array to plist, \(error)")
        }
        // now we need to reload our table view
        self.tableView.reloadData()
    }
    
}


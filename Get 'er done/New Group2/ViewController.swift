//
//  ViewController.swift
//  Get 'er done
//
//  Created by Edwin Ruiz on 12/24/17.
//  Copyright © 2017 Edwin Ruiz. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UITableViewController {
    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    let defaults = UserDefaults.standard
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        if let items = defaults.array(forKey: "listArray") as? [String] {
//            itemArray = items
//        }
        
        loadItems()
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
            
            
            let item = Item(context: self.context)
            item.title = textField.text!
            item.done = false
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
            try context.save()
        }catch{
           print("Error saving context \(error)")
        }
        // now we need to reload our table view
        self.tableView.reloadData()
    }
    
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()){
        // read items from database with the request sent as parameter or default Item.fetchRequest()
        do{
           itemArray = try context.fetch(request)
        }catch{
            print("Error fetching data from context \(error)")
        }
        
        tableView.reloadData()
    }
    


}

//MARK: - Search bar methods
extension ViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        // query for whatever the user searched
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItems(with: request)

    }
}


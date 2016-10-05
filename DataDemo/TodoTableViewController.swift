//
//  TodoTableViewController.swift
//  DataDemo
//
//  Created by Stannis Baratheon on 05/10/16.
//  Copyright © 2016 Training. All rights reserved.
//

import UIKit
import CoreData

class TodoTableViewController: UITableViewController {
    
    var todos = [Todo] ()
    
    var context:NSManagedObjectContext!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        let del = UIApplication.shared.delegate as! AppDelegate
        
        context = del.persistentContainer.viewContext
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
        fetchTodos()
        
    }
    
    func fetchTodos() {
        
        
    
        let request: NSFetchRequest<Todo> = Todo.fetchRequest()
        
        let sort = NSSortDescriptor(key: "createdAt", ascending: false)
        
        request.sortDescriptors = [sort]
        
        let asyncRequest = NSAsynchronousFetchRequest<Todo> (fetchRequest: request) { (result) in
            self.todos = result.finalResult ?? []
            self.tableView.reloadData()
            
            
            }
        
        do {
        
            try context.execute(asyncRequest)
            
        } catch let error {
          
            print(error)
        
        }
        
        
        
        
//        context.perform {
//        do {
//            self.todos = try request.execute()
//            self.tableView.reloadData()
//        } catch let error {
//        
//            print(error)
//        }
//        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return todos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todosCell", for: indexPath)

        let todo = todos[indexPath.row]
        
        cell.textLabel?.text = todo.title
        
        if todo.done {
        
            cell.accessoryType = .checkmark
            
        } else {
        
            cell.accessoryType = .none
        
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todo = todos[indexPath.row]
        
        todo.done = !todo.done
        
        do {
            try context.save()
            tableView.reloadRows(at: [indexPath], with: .automatic)
            tableView.deselectRow(at: indexPath, animated: true)
        } catch let error {
            print(error)
        }
        
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            do {
                let todo = todos.remove(at: indexPath.row)
                context.delete(todo)
                
                
                try context.save()
                tableView.deleteRows(at: [indexPath], with: .fade)
                
            } catch let error {
                print(error)
            }
            // Delete the row from the data source
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

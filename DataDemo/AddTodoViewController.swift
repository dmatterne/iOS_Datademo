//
//  AddTodoViewController.swift
//  DataDemo
//
//  Created by Stannis Baratheon on 05/10/16.
//  Copyright © 2016 Training. All rights reserved.
//

import UIKit
import CoreData

class AddTodoViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleField: UITextField!
    var context: NSManagedObjectContext!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let del = UIApplication.shared.delegate as! AppDelegate

        context = del.persistentContainer.viewContext
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

  
    
    
    @IBAction func saveTodos(_ sender: UIBarButtonItem) {
        
        let todo = NSEntityDescription.insertNewObject(forEntityName: "Todo", into: context) as! Todo
        
        todo.title = titleField.text
        todo.done = false
        todo.createdAt = NSDate()
        
        do {
            
            try context.save()
            dismiss(animated: true, completion: nil)
        
        } catch let error {
                print(error)
        }
        
        
    }
   
    
    @IBAction func cancelAddTodos(_ sender: UIBarButtonItem) {
        
        dismiss(animated: true, completion: nil)
        
    }
}

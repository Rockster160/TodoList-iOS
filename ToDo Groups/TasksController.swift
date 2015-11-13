//
//  TasksController.swift
//  ToDo Groups
//
//  Created by Rocco Nicholls on 11/12/15.
//  Copyright © 2015 Rocco Nicholls. All rights reserved.
//

import UIKit

class TasksController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    var group_index : Int?
    var group_name : String {
        get {
            return groups[group_index!].keys.first!
        }
    }

    @IBOutlet var navTitle: UINavigationItem!
    @IBOutlet var table: UITableView!
    @IBAction func backBtn(sender: AnyObject) {
        performSegueWithIdentifier("back", sender: nil)
    }
    @IBAction func addGroupBtn(sender: AnyObject) {
        let alert = UIAlertController(title: "Add Task", message: "Enter the name for the new Task", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addTextFieldWithConfigurationHandler({
            groupNameField in
            groupNameField.placeholder = "Task Name"
            groupNameField.autocapitalizationType = UITextAutocapitalizationType.Sentences
            groupNameField.delegate = self
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: {
            action in
            if let text_field = alert.textFields?.first {
                self.addCell(text_field.text!)
            }
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navTitle.title = group_name
    }
    
    override func viewDidAppear(animated: Bool) {
        table.reloadData()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        addCell(textField.text!)
        dismissViewControllerAnimated(true, completion: nil)
        return true
    }
    
    func addCell(name : String) {
        groups[group_index!][group_name]! += [name]
        NSUserDefaults.standardUserDefaults().setObject(groups, forKey: "group_list")
        table.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups[group_index!][group_name]!.count
    }
    
//    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
//        group_index_to_send = indexPath.row
//        performSegueWithIdentifier("toTasks", sender: nil)
//        return indexPath
//    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "Cell")
        cell.textLabel?.text = groups[group_index!][group_name]![indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            groups[group_index!][group_name]!.removeAtIndex(indexPath.row)
            NSUserDefaults.standardUserDefaults().setObject(groups, forKey: "group_list")
            table.reloadData()
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
}


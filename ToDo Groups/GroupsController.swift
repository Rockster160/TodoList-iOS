//
//  GroupsController.swift
//  ToDo Groups
//
//  Created by Rocco Nicholls on 11/12/15.
//  Copyright © 2015 Rocco Nicholls. All rights reserved.
//

import UIKit

var groups = [[String:[String]]]()

class GroupsController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    @IBOutlet var table: UITableView!
    
    var group_index_to_send : Int?
    
    @IBAction func addGroupBtn(sender: AnyObject) {
        let alert = UIAlertController(title: "Add Group", message: "Enter the name for the new Group", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addTextFieldWithConfigurationHandler({
            groupNameField in
            groupNameField.placeholder = "Group Name"
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
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        addCell(textField.text!)
        dismissViewControllerAnimated(true, completion: nil)
        return true
    }
    
    func addCell(name : String) {
        groups.append([name: [String]()])
        NSUserDefaults.standardUserDefaults().setObject(groups, forKey: "group_list")
        table.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toTasks" {
            let task_controller = segue.destinationViewController as! TasksController
            task_controller.group_index = group_index_to_send!
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (NSUserDefaults.standardUserDefaults().objectForKey("group_list") != nil) {
            groups = NSUserDefaults.standardUserDefaults().objectForKey("group_list") as! [[String:[String]]]
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        table.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        group_index_to_send = indexPath.row
        performSegueWithIdentifier("toTasks", sender: nil)
        return indexPath
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "Cell")
        cell.textLabel?.text = groups[indexPath.row].keys.first
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            groups.removeAtIndex(indexPath.row)
            NSUserDefaults.standardUserDefaults().setObject(groups, forKey: "group_list")
            table.reloadData()
        }
    }
    
}


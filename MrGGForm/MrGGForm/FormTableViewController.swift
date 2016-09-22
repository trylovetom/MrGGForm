//
//  FormTableViewController.swift
//  MrGGForm
//
//  Created by 張子晏 on 2016/6/20.
//  Copyright © 2016年 張子晏. All rights reserved.
//

import UIKit
import SwiftyJSON

class FormTableViewController: UITableViewController {
    let formDataController = FormDataController()
    var addButton = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(FormTableViewController.addAction))
        self.navigationItem.leftBarButtonItem = addButton
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return formDataController.formArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        
        cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "Cell")
        }
        
        cell?.textLabel?.text = formDataController.formArray[indexPath.item]
        
        return cell!
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            formDataController.formArray.removeAtIndex(indexPath.item)
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    /*
     // Override to support rearranging the table view.
     override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: - TableViewDelegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let fileManager = NSFileManager.defaultManager()
        let documents = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        let filePath = documents.stringByAppendingString("/" + String(formDataController.formArray[indexPath.item]) + ".json")
        let targetPath: String
        
        if fileManager.fileExistsAtPath(filePath) {
            targetPath = filePath
            print("FILE AVAILABLE")
        } else {
            print("FILE NOT AVAILABLE")
            targetPath = ""
        }
        
        if let jsonData = NSData(contentsOfFile: targetPath) {
            if let section = Section.build(JSON(data: jsonData)) {
                let sectionEditTableViewController = SectionEditTableViewController(section: section)
                //                                            let navigationController = UINavigationController(rootViewController: sectionEditTableViewController)
                
                self.navigationController?.pushViewController(sectionEditTableViewController, animated: true)
            }
        }
    }
    
    
    // MARK: - Action
    
    func addAction() {
        let alertControlelr = UIAlertController(title: "New Form", message: "Type Name", preferredStyle: .Alert)
        
        alertControlelr.addTextFieldWithConfigurationHandler({ (textField: UITextField!) in
        })
        alertControlelr.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { (alertAction: UIAlertAction) in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        alertControlelr.addAction(UIAlertAction(title: "Create", style: .Default, handler: { (alertAction: UIAlertAction) in
            if alertControlelr.textFields?.first?.text == nil {
                print("Name can't be nil")
                return
            }
            for name in self.formDataController.formArray {
                if name == alertControlelr.textFields?.first?.text {
                    print("Name has been exist")
                    return
                }
            }
            if let path = NSBundle.mainBundle().pathForResource("SectionStruct", ofType: "json") {
                let fileManager = NSFileManager.defaultManager()
                let documents = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
                let filePath = documents.stringByAppendingString("/SectionStruct.json")
                let targetPath: String
                
                if fileManager.fileExistsAtPath(filePath) {
                    targetPath = filePath
                    print("FILE AVAILABLE")
                } else {
                    targetPath = path
                    print("FILE NOT AVAILABLE")
                }
                
                if let jsonData = NSData(contentsOfFile: targetPath) {
                    if let section = Section.build(JSON(data: jsonData)) {
                        section.title = (alertControlelr.textFields?.first?.text)!
                        self.formDataController.formArray.append((alertControlelr.textFields?.first?.text)!)
                        self.formDataController.save()
                        self.tableView.reloadData()
                        
                        let sectionEditTableViewController = SectionEditTableViewController(section: section)
                        //                                            let navigationController = UINavigationController(rootViewController: sectionEditTableViewController)
                        
                        self.navigationController?.pushViewController(sectionEditTableViewController, animated: true)
                    }
                }
            }
        }))
        self.presentViewController(alertControlelr, animated: true, completion: nil)
    }
    
}

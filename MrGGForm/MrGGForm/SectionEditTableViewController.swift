//
//  SectionTableEditViewController.swift
//  MrGGForm
//
//  Created by 張子晏 on 2016/6/5.
//  Copyright © 2016年 張子晏. All rights reserved.
//

import UIKit
import SwiftyJSON

class SectionEditTableViewController: UITableViewController, SectionTableViewControllerProtocol {
    var section: Section
    var addButton: UIBarButtonItem?
    var saveButton: UIBarButtonItem?
    
    // MARK: - Initializer
    init(section: Section) {
        self.section = section
        self.addButton = nil
        self.saveButton = nil
        super.init(style: .Plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(SectionEditTableViewController.addAction))
        self.saveButton = UIBarButtonItem(barButtonSystemItem: .Save, target: self, action: #selector(SectionEditTableViewController.saveAction))
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.navigationItem.leftBarButtonItem = saveButton
        self.title = section.title
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table View Data Source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.section.questions.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let question = self.section.questions[indexPath.item]
        var cell: UITableViewCell?
        
//        switch question.type {
//        case .ShortAnswer:
//            cell = tableView.dequeueReusableCellWithIdentifier(QuestionType.ShortAnswer.rawValue)
//            
//            break
//        case .Paragraph:
//            cell = tableView.dequeueReusableCellWithIdentifier(QuestionType.Paragraph.rawValue)
//            break
//        case .CheckBoxes:
//            cell = tableView.dequeueReusableCellWithIdentifier(QuestionType.CheckBoxes.rawValue)
//            break
//        case .MultipleChoice:
//            cell = tableView.dequeueReusableCellWithIdentifier(QuestionType.MultipleChoice.rawValue)
//            break
//        case .DropDown:
//            cell = tableView.dequeueReusableCellWithIdentifier(QuestionType.DropDown.rawValue)
//            break
//        case .LinearScale:
//            cell = tableView.dequeueReusableCellWithIdentifier(QuestionType.LinearScale.rawValue)
//            break
//        }
        
        if cell == nil {
            switch question.type {
            case .ShortAnswer:
                cell = ShortAnswerTableViewCell(shortAnswer: question as! ShortAnswer)
                break
            case .Paragraph:
                cell = ParagraphTableViewCell(paragraph: question as! Paragraph)
                break
            case .CheckBoxes:
                cell = CheckBoxesTableViewCell(checkBoxes: question as! CheckBoxes)
                break
            case .MultipleChoice:
                cell = MultipleChoiceTableView(multiple: question as! MultipleChoice)
                break
            case .DropDown:
                cell = DropDownTableViewCell(dropDown: question as! DropDown)
                break
            case .LinearScale:
                cell = LinearScaleTableViewCell(linearScale: question as! LinearScale)
                break
            }
        }
        
        return cell!
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            self.section.questions.removeAtIndex(indexPath.item)
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        let question = section.questions[fromIndexPath.item]
        
        section.questions.removeAtIndex(fromIndexPath.item)
        section.questions.insert(question, atIndex: toIndexPath.item)
    }
    
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let question = self.section.questions[indexPath.item]
        
        switch question.type {
        case .MultipleChoice:
            return CGFloat((question as! MultipleChoice).values.count * 44 + 30)
        case .Paragraph:
            return 150
        case .CheckBoxes:
            return CGFloat((question as! CheckBoxes).values.count * 44 + 30)
        case .DropDown:
            return 120
        default:
            return 80
        }
    }
    
    // MARK: - Button Action
    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if (self.editing) {
            self.navigationItem.leftBarButtonItem = addButton
        } else {
            self.navigationItem.leftBarButtonItem = saveButton
        }
    }
    
    func addAction() {
        let json: JSON = [
            "id": "AddQuestion",
            "title": "Add Question",
            "description": "sectionDescription",
            "questions": [
                [
                    "id": "id",
                    "title": "Type Question ID",
                    "type": "shortAnswer",
                    "placeholder": "id",
                    "required": true
                ],[
                    "id": "title",
                    "title": "Type Question Title",
                    "type": "shortAnswer",
                    "placeholder": "title",
                    "required": true
                ],[
                    "id": "type",
                    "title": "Choice Question type",
                    "type": "dropDown",
                    "values": [
                        "shortAnswer",
                        "paragraph",
                        "checkBoxes",
                        "multipleChoice",
                        "dropDown",
                        "linearScale"
                    ],
                    "required": true
                ], [
                    "id": "placeholder",
                    "title": "Type Question Placeholder",
                    "type": "shortAnswer",
                    "placeholder": "placeholder",
                    "required": true
                ], [
                    "id": "values",
                    "title": "Type Question Values",
                    "type": "paragraph",
                    "placeholder": "value1",
                    "required": true
                ]
            ]
        ]
        if let section = Section.build(json) {
            let sectionTableViewController = SectionTableViewController(section: section)
            let navigationController = UINavigationController(rootViewController: sectionTableViewController)
            
            sectionTableViewController.delegate = self
            self.navigationController?.presentViewController(navigationController, animated: true, completion: nil)
        }
    }
    
    func saveAction() {
        let documents = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        let path = "/" + section.title + ".json" // "/SectionStruct.json"
        let writePath = documents.stringByAppendingString(path)
        
        do {
            let data = try section.json().rawData()
            data.writeToFile(writePath, atomically: true)
            print(writePath)
        } catch {
            print(error)
        }
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK: - SecionTableViewControllerDelegate
    
    func sectionDidFinished(replyJson: JSON) {
        if let type = replyJson["type"].string {
            switch type {
            case QuestionType.ShortAnswer.rawValue:
                section.questions.append(ShortAnswer(id: replyJson["id"].stringValue, title: replyJson["title"].stringValue, type: QuestionType.ShortAnswer.rawValue, required: true, placeholder: replyJson["placeholder"].stringValue))
                tableView.reloadData()
                break
            case QuestionType.Paragraph.rawValue:
                section.questions.append(Paragraph(id: replyJson["id"].stringValue, title: replyJson["title"].stringValue, type: QuestionType.ShortAnswer.rawValue, required: true, placeholder: replyJson["placeholder"].stringValue))
                tableView.reloadData()
                break
            case QuestionType.CheckBoxes.rawValue:
                var values = [String]()
                
                for value in replyJson["values"].arrayValue {
                    values.append(value.stringValue)
                }
                section.questions.append(CheckBoxes(id: replyJson["id"].stringValue, title: replyJson["title"].stringValue, type: QuestionType.CheckBoxes.rawValue, required: true, values: values))
                tableView.reloadData()
                break
            case QuestionType.MultipleChoice.rawValue:
                var values = [String]()
                
                for value in replyJson["values"].arrayValue {
                    values.append(value.stringValue)
                }
                section.questions.append(MultipleChoice(id: replyJson["id"].stringValue, title: replyJson["title"].stringValue, type: QuestionType.CheckBoxes.rawValue, required: true, values: values))
                tableView.reloadData()
                break
            case QuestionType.DropDown.rawValue:
                var values = [String]()
                
                for value in replyJson["values"].arrayValue {
                    values.append(value.stringValue)
                }
                section.questions.append(DropDown(id: replyJson["id"].stringValue, title: replyJson["title"].stringValue, type: QuestionType.CheckBoxes.rawValue, required: true, values: values))
                tableView.reloadData()
                break
            case QuestionType.LinearScale.rawValue:
                var values = [String]()
                
                for value in replyJson["values"].arrayValue {
                    values.append(value.stringValue)
                }
                section.questions.append(LinearScale.init(id: replyJson["id"].stringValue, title: replyJson["title"].stringValue, type: QuestionType.CheckBoxes.rawValue, required: true, maxValue: NSNumber(float: Float(values[0])!), minValue: NSNumber(float: Float(values[1])!)))
                tableView.reloadData()
                break
            default:
                break
            }
        }
    }
}

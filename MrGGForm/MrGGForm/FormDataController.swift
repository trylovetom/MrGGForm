//
//  FormDataController.swift
//  
//
//  Created by 張子晏 on 2016/5/18.
//
//

import Foundation
import SwiftyJSON

class FormDataController {
    var formArray: [String]
    
    init() {
        let formData = NSUserDefaults.standardUserDefaults().objectForKey("form") as? NSData
        
        if let formData = formData {
            let formArray = NSKeyedUnarchiver.unarchiveObjectWithData(formData) as? [String]
            
            if let formArray = formArray {
                self.formArray = formArray
            } else {
                self.formArray = [String]()
            }
        } else {
            self.formArray = [String]()
        }
    }
    
    func save() {
        let formName = NSKeyedArchiver.archivedDataWithRootObject(formArray)
        
        NSUserDefaults.standardUserDefaults().setObject(formName, forKey: "form")
    }
    
    func load() {
        let formData = NSUserDefaults.standardUserDefaults().objectForKey("form") as? NSData
        
        if let formData = formData {
            let formArray = NSKeyedUnarchiver.unarchiveObjectWithData(formData) as? [String]
            
            if let formArray = formArray {
                self.formArray = formArray
            } else {
                self.formArray = [String]()
            }
        } else {
            self.formArray = [String]()
        }
    }
}

//
//  FormDataController.swift
//  
//
//  Created by 張子晏 on 2016/5/18.
//
//

import Foundation
import SwiftyJSON

func getJsonFormByFile() -> JSON? {
    if let path = NSBundle.mainBundle().pathForResource("FormStruct", ofType: "json") {
        if let jsonData = NSData(contentsOfFile: path) {
            return JSON(data: jsonData)
        }
    }
    return nil
}

class FormDataController {
    var form: Form
    
    init() {
        self.form = Form.build(getJsonFormByFile()!)!
    }
}

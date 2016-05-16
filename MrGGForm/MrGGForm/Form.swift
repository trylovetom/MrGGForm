//
//  Form.swift
//  MrGGForm
//
//  Created by 張子晏 on 2016/5/16.
//  Copyright © 2016年 張子晏. All rights reserved.
//

import Foundation
import SwiftyJSON

class Form {
    let id: String
    let title: String
    let sections: [Section]
    
    init(id: String, title: String, sections: [Section]) {
        self.id = id
        self.title = title
        self.sections = sections
    }
    
    class func build(json: JSON) -> Form? {
        if let id = json["id"].string,
            title = json["title"].string,
            sections = json["sections"].array {
            var sectionObjects = [Section]()
            
            for section in sections {
                if let sectionObject = Section.build(section) {
                    sectionObjects.append(sectionObject)
                } else {
                    debugPrint("Error: bad json")
                    debugPrint(json)
                    return nil
                }
            }
            return Form(id: id, title: title, sections: sectionObjects)
        } else {
            debugPrint("Error: bad json")
            debugPrint(json)
            return nil
        }
    }
}

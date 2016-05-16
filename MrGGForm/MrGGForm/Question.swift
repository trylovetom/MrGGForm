//
//  Question.swift
//  MrGGForm
//
//  Created by 張子晏 on 2016/5/16.
//  Copyright © 2016年 張子晏. All rights reserved.
//

import Foundation
import SwiftyJSON

enum QuestionType:String {
    case ShortAnswer = "shortAnswer"
    case Paragraph = "paragraph"
    case CheckBoxes = "checkBoxes"
    case MultipleChoice = "multipleChoice"
    case DropDown = "dropDown"
    case LinearScale = "linearScale"
}

class Question {
    let id: String
    let title: String
    let type: QuestionType
    let required: Bool
    
    init(id: String, title: String, type: QuestionType, required: Bool) {
        self.id = id
        self.title = title
        self.type = type
        self.required = required
    }
}

class ShortAnswer: Question {
    let placeholder: String
    
    init(id: String, title: String, type: String, required: Bool, placeholder: String) {
        self.placeholder = placeholder
        super.init(id: id, title: title, type: .ShortAnswer, required: required)
    }
    
    class func build(json: JSON) -> ShortAnswer? {
        if let id = json["id"].string,
            title = json["title"].string,
            type = json["type"].string,
            required = json["required"].bool,
            placeholder = json["placeholder"].string {
            
            return ShortAnswer(id: id, title: title, type: type, required: required, placeholder: placeholder)
        } else {
            debugPrint("Error: bad json")
            debugPrint(json)
            return nil
        }
    }
}

class Paragraph: Question {
    let placeholder: String
    
    init(id: String, title: String, type: String, required: Bool, placeholder: String) {
        self.placeholder = placeholder
        super.init(id: id, title: title, type: .Paragraph, required: required)
    }
    
    class func build(json: JSON) -> Paragraph? {
        if let id = json["id"].string,
            title = json["title"].string,
            type = json["type"].string,
            required = json["required"].bool,
            placeholder = json["placeholder"].string {
            
            return Paragraph(id: id, title: title, type: type, required: required, placeholder: placeholder)
        } else {
            debugPrint("Error: bad json")
            debugPrint(json)
            return nil
        }
    }
}

class CheckBoxes: Question {
    let values: [String]
    
    init(id: String, title: String, type: String, required: Bool, values: [String]) {
        self.values = values
        super.init(id: id, title: title, type: .CheckBoxes, required: required)
    }
    
    class func build(json: JSON) -> CheckBoxes? {
        if let id = json["id"].string,
            title = json["title"].string,
            type = json["type"].string,
            required = json["required"].bool,
            values = json["values"].array {
            let valueStrings =  values.map({ $0.stringValue })
            
            return CheckBoxes(id: id, title: title, type: type, required: required, values: valueStrings)
        } else {
            debugPrint("Error: bad json")
            debugPrint(json)
            return nil
        }
    }
}

class MultipleChoice: Question {
    let values: [String]
    
    init(id: String, title: String, type: String, required: Bool, values: [String]) {
        self.values = values
        super.init(id: id, title: title, type: .MultipleChoice, required: required)
    }
    
    class func build(json: JSON) -> MultipleChoice? {
        if let id = json["id"].string,
            title = json["title"].string,
            type = json["type"].string,
            required = json["required"].bool,
            values = json["values"].array {
            let valueStrings =  values.map({ $0.stringValue })
            
            return MultipleChoice(id: id, title: title, type: type, required: required, values: valueStrings)
        } else {
            debugPrint("Error: bad json")
            debugPrint(json)
            return nil
        }
    }
}

class DropDown: Question {
    let values: [String]
    
    init(id: String, title: String, type: String, required: Bool, values: [String]) {
        self.values = values
        super.init(id: id, title: title, type: .DropDown, required: required)
    }
    
    class func build(json: JSON) -> DropDown? {
        if let id = json["id"].string,
            title = json["title"].string,
            type = json["type"].string,
            required = json["required"].bool,
            values = json["values"].array {
            let valueStrings =  values.map({ $0.stringValue })
            
            return DropDown(id: id, title: title, type: type, required: required, values: valueStrings)
        } else {
            debugPrint("Error: bad json")
            debugPrint(json)
            return nil
        }
    }
}

class LinearScale: Question {
    let maxValue: NSNumber
    let minValue: NSNumber
    
    init(id: String, title: String, type: String, required: Bool, maxValue: NSNumber, minValue: NSNumber) {
        self.maxValue = maxValue
        self.minValue = minValue
        super.init(id: id, title: title, type: .LinearScale, required: required)
    }
    
    class func build(json: JSON) -> LinearScale? {
        if let id = json["id"].string,
            title = json["title"].string,
            type = json["type"].string,
            required = json["required"].bool,
            maxValue = json["maxValue"].number,
            minValue = json["minValue"].number {
            
            return LinearScale(id: id, title: title, type: type, required: required, maxValue: maxValue, minValue: minValue)
        } else {
            debugPrint("Error: bad json")
            debugPrint(json)
            return nil
        }
    }
}

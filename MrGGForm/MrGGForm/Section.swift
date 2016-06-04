//
//  Section.swift
//  MrGGForm
//
//  Created by 張子晏 on 2016/5/16.
//  Copyright © 2016年 張子晏. All rights reserved.
//

import Foundation
import SwiftyJSON

class Section {
    let id: String
    let title: String
    let description: String
    let questions: [Question]
    
    init(id: String, title: String, description: String, questions: [Question]) {
        self.id = id
        self.title = title
        self.description = description
        self.questions = questions
    }
    
    class func build(json: JSON) -> Section? {
        if let id = json["id"].string,
            title = json["title"].string,
            description = json["description"].string,
            questions = json["questions"].array {
            var questionsObjects = [Question]()
            
            for question in questions {
                if let type = question["type"].string {
                    if let questionObject = self.questionMaker(type, json: question) {
                        questionsObjects.append(questionObject)
                    } else {
                        debugPrint("Error: bad json")
                        debugPrint(json)
                        return nil
                    }
                } else {
                    debugPrint("Error: bad json")
                    debugPrint(json)
                    return nil
                }
            }
            
            return Section(id: id, title: title, description: description, questions: questionsObjects)
        } else {
            debugPrint("Error: bad json")
            debugPrint(json)
            return nil
        }
    }
    
    class func questionMaker(type: String, json: JSON) -> Question? {
        switch type {
        case QuestionType.ShortAnswer.rawValue:
            if let shortAnswer = ShortAnswer.build(json) {
                return shortAnswer
            }
        case QuestionType.Paragraph.rawValue:
            if let paragraph = Paragraph.build(json) {
                return paragraph
            }
        case QuestionType.CheckBoxes.rawValue:
            if let checkBoxes = CheckBoxes.build(json) {
                return checkBoxes
            }
        case QuestionType.MultipleChoice.rawValue:
            if let multipleChoice = MultipleChoice.build(json) {
                return multipleChoice
            }
        case QuestionType.DropDown.rawValue:
            if let dropDown = DropDown.build(json) {
                return dropDown
            }
        case QuestionType.LinearScale.rawValue:
            if let linearScale = LinearScale.build(json) {
                return linearScale
            }
        default:
            return nil
        }
        return nil
    }
    
    func json() -> JSON {
        var questionsJson = [JSON]()
        
        for question in questions {
            switch question.type {
            case QuestionType.ShortAnswer:
                questionsJson.append((question as! ShortAnswer).json())
                break
            case QuestionType.Paragraph:
                questionsJson.append((question as! Paragraph).json())
            case QuestionType.CheckBoxes:
                questionsJson.append((question as! CheckBoxes).json())
            case QuestionType.MultipleChoice:
                questionsJson.append((question as! MultipleChoice).json())
            case QuestionType.DropDown:
                questionsJson.append((question as! DropDown).json())
            case QuestionType.LinearScale:
                questionsJson.append((question as! LinearScale).json())
            }
        }
        
        var json = JSON([
            "id": id,
            "title": title,
            "description": description,
            ])
        json["questions"] = JSON(questionsJson)
        
        return json
    }
}

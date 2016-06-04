//
//  MrGGFormModelTest.swift
//  MrGGForm
//
//  Created by 張子晏 on 2016/5/16.
//  Copyright © 2016年 張子晏. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import MrGGForm

class MrGGFormModelTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        // self.measureBlock {
        // Put the code you want to measure the time of here.
        // }
    }
    
    func testModelShortAnswer() {
        // Default
        let json1: JSON = [
            "id": "questionID1",
            "title": "questionTitle",
            "type": "shortAnswer",
            "placeholder": "placeholder",
            "required": true
        ]
        
        self.testModelShortAnswerByJson(ShortAnswer.build(json1)!, json: json1)
        
        
        // Error Handle
        let json2: JSON = [
            "title": "questionTitle",
            "type": "shortAnswer",
            "placeholder": "placeholder",
            "required": true
        ]
        
        if ShortAnswer.build(json2) != nil {
            XCTFail()
        }
    }
    
    func testModelParagraph() {
        // Default
        let json1: JSON = [
            "id": "questionID2",
            "title": "questionTitle",
            "type": "paragraph",
            "placeholder": "placeholder",
            "required": false
        ]
        
        self.testModelParagraphByJson(Paragraph.build(json1)!, json: json1)
        
        // Error Handle Miss ID
        let json2: JSON = [
            "title": "questionTitle",
            "type": "paragraph",
            "placeholder": "placeholder",
            "required": false
        ]
        
        if Paragraph.build(json2) != nil {
            XCTFail()
        }
    }
    
    func testModelCheckBoxes() {
        // Default
        let json1: JSON = [
            "id": "questionID3",
            "title": "questionTitle",
            "type": "checkBoxes",
            "values": [
                "buttonTitle1",
                "buttonTitle2"
            ],
            "required": true
        ]
        
        self.testModelCheckBoxesByJson(CheckBoxes.build(json1)!, json: json1)
        
        // Error Handle Miss ID
        let json2: JSON = [
            "title": "questionTitle",
            "type": "checkBoxes",
            "values": [
                "buttonTitle1",
                "buttonTitle2"
            ],
            "required": true
        ]
        
        if CheckBoxes.build(json2) != nil {
            XCTFail()
        }
    }
    
    func testModelMultipleChoice() {
        // Default
        let json1: JSON = [
            "id": "questionID4",
            "title": "questionTitle",
            "type": "multipleChoice",
            "values": [
                "buttonTitle1",
                "buttonTitle2"
            ],
            "required": true
        ]
        
        self.testModelMultipleChoiceByJson(MultipleChoice.build(json1)!, json: json1)
        
        // Error Handle Miss ID
        let json2: JSON = [
            "title": "questionTitle",
            "type": "multipleChoice",
            "values": [
                "buttonTitle1",
                "buttonTitle2"
            ],
            "required": true
        ]
        
        if MultipleChoice.build(json2) != nil {
            XCTFail()
        }
    }
    
    func testModelDropDown() {
        // Default
        let json1: JSON = [
            "id": "questionID5",
            "title": "questionTitle",
            "type": "dropDown",
            "values": [
                "buttonTitle1",
                "buttonTitle2"
            ],
            "required": true
        ]
        
        self.testModelDropDownByJson(DropDown.build(json1)!, json: json1)
        
        // Error Handle Miss ID
        let json2: JSON = [
            "title": "questionTitle",
            "type": "dropDown",
            "values": [
                "buttonTitle1",
                "buttonTitle2"
            ],
            "required": true
        ]
        
        if DropDown.build(json2) != nil {
            XCTFail()
        }
    }
    
    func testModelLinearScale() {
        // Default
        let json1: JSON = [
            "id": "questionID6",
            "title": "questionTitle",
            "type": "linearScale",
            "maxValue": 5,
            "minValue": 0,
            "required": true
        ]
        
        self.testModelLinearScaleByJson(LinearScale.build(json1)!, json: json1)
        
        // Error Handle Miss ID
        let json2: JSON = [
            "title": "questionTitle",
            "type": "linearScale",
            "maxValue": 5,
            "minValue": 0,
            "required": true
        ]
        
        if DropDown.build(json2) != nil {
            XCTFail()
        }
    }
    
    func testModelShortAnswerByJson(shortAnswer: ShortAnswer, json: JSON) {
        // Import
        XCTAssertEqual(shortAnswer.id, json["id"].string)
        XCTAssertEqual(shortAnswer.title, json["title"].string)
        XCTAssertEqual(shortAnswer.type.rawValue, json["type"].string)
        XCTAssertEqual(shortAnswer.required, json["required"].bool)
        XCTAssertEqual(shortAnswer.placeholder, json["placeholder"].string)
        
        // Export
        let output = shortAnswer.json()
        
        XCTAssertEqual(output["id"].string, json["id"].string)
        XCTAssertEqual(output["title"].string, json["title"].string)
        XCTAssertEqual(output["type"].string, json["type"].string)
        XCTAssertEqual(output["required"].bool, json["required"].bool)
        XCTAssertEqual(output["placeholder"].string, json["placeholder"].string)
    }
    
    func testModelParagraphByJson(paragraph: Paragraph, json: JSON) {
        // Import
        XCTAssertEqual(paragraph.id, json["id"].string)
        XCTAssertEqual(paragraph.title, json["title"].string)
        XCTAssertEqual(paragraph.type.rawValue, json["type"].string)
        XCTAssertEqual(paragraph.required, json["required"].bool)
        XCTAssertEqual(paragraph.placeholder, json["placeholder"].string)
        
        // Export
        let output = paragraph.json()
        
        XCTAssertEqual(output["id"].string, json["id"].string)
        XCTAssertEqual(output["title"].string, json["title"].string)
        XCTAssertEqual(output["type"].string, json["type"].string)
        XCTAssertEqual(output["required"].bool, json["required"].bool)
        XCTAssertEqual(output["placeholder"].string, json["placeholder"].string)
    }
    
    func testModelCheckBoxesByJson(checkBoxes: CheckBoxes, json: JSON) {
        // Import
        XCTAssertEqual(checkBoxes.id, json["id"].string)
        XCTAssertEqual(checkBoxes.title, json["title"].string)
        XCTAssertEqual(checkBoxes.type.rawValue, json["type"].string)
        XCTAssertEqual(checkBoxes.required, json["required"].bool)
        for i in 0 ..< checkBoxes.values.count {
            let value = checkBoxes.values[i]
            
            XCTAssertEqual(value, json["values"].array![i].string)
        }
        
        // Export
        let output = checkBoxes.json()
        
        XCTAssertEqual(output["id"].string, json["id"].string)
        XCTAssertEqual(output["title"].string, json["title"].string)
        XCTAssertEqual(output["type"].string, json["type"].string)
        XCTAssertEqual(output["required"].bool, json["required"].bool)
        for i in 0 ..< output["values"].arrayValue.count {
            let value = output["values"].arrayValue[i]
            
            XCTAssertEqual(value.string, json["values"].array![i].string)
        }
    }
    
    func testModelMultipleChoiceByJson(multipleChoice: MultipleChoice, json: JSON) {
        // Import
        XCTAssertEqual(multipleChoice.id, json["id"].string)
        XCTAssertEqual(multipleChoice.title, json["title"].string)
        XCTAssertEqual(multipleChoice.type.rawValue, json["type"].string)
        XCTAssertEqual(multipleChoice.required, json["required"].bool)
        for i in 0 ..< multipleChoice.values.count {
            let value = multipleChoice.values[i]
            
            XCTAssertEqual(value, json["values"].array![i].string)
        }
        
        // Export
        let output = multipleChoice.json()
        
        XCTAssertEqual(output["id"].string, json["id"].string)
        XCTAssertEqual(output["title"].string, json["title"].string)
        XCTAssertEqual(output["type"].string, json["type"].string)
        XCTAssertEqual(output["required"].bool, json["required"].bool)
        for i in 0 ..< output["values"].arrayValue.count {
            let value = output["values"].arrayValue[i]
            
            XCTAssertEqual(value.string, json["values"].array![i].string)
        }
    }
    
    func testModelDropDownByJson(dropDown: DropDown, json: JSON) {
        // Import
        XCTAssertEqual(dropDown.id, json["id"].string)
        XCTAssertEqual(dropDown.title, json["title"].string)
        XCTAssertEqual(dropDown.type.rawValue, json["type"].string)
        XCTAssertEqual(dropDown.required, json["required"].bool)
        for i in 0 ..< dropDown.values.count {
            let value = dropDown.values[i]
            
            XCTAssertEqual(value, json["values"].array![i].string)
        }
        
        // Export
        let output = dropDown.json()
        
        XCTAssertEqual(output["id"].string, json["id"].string)
        XCTAssertEqual(output["title"].string, json["title"].string)
        XCTAssertEqual(output["type"].string, json["type"].string)
        XCTAssertEqual(output["required"].bool, json["required"].bool)
        for i in 0 ..< output["values"].arrayValue.count {
            let value = output["values"].arrayValue[i]
            
            XCTAssertEqual(value.string, json["values"].array![i].string)
        }
    }
    
    func testModelLinearScaleByJson(linearScale: LinearScale,json: JSON) {
        // Import
        XCTAssertEqual(linearScale.id, json["id"].string)
        XCTAssertEqual(linearScale.title, json["title"].string)
        XCTAssertEqual(linearScale.type.rawValue, json["type"].string)
        XCTAssertEqual(linearScale.required, json["required"].bool)
        XCTAssertEqual(linearScale.maxValue, json["maxValue"].number)
        XCTAssertEqual(linearScale.minValue, json["minValue"].number)
        
        // Export
        let output = linearScale.json()
        
        XCTAssertEqual(output["id"].string, json["id"].string)
        XCTAssertEqual(output["title"].string, json["title"].string)
        XCTAssertEqual(output["type"].string, json["type"].string)
        XCTAssertEqual(output["required"].bool, json["required"].bool)
        XCTAssertEqual(output["maxValue"].number, json["maxValue"].number)
        XCTAssertEqual(output["minValue"].number, json["minValue"].number)
    }
    
    func testModelSection() {
        let json1: JSON = [
            "id": "sectionID1",
            "title": "sectionTitle",
            "description": "sectionDescription",
            "questions": [
                [
                    "id": "questionID1",
                    "title": "questionTitle",
                    "type": "shortAnswer",
                    "placeholder": "placeholder",
                    "required": true
                ], [
                    "id": "questionID2",
                    "title": "questionTitle",
                    "type": "paragraph",
                    "placeholder": "placeholder",
                    "required": false
                ], [
                    "id": "questionID3",
                    "title": "questionTitle",
                    "type": "checkBoxes",
                    "values": [
                        "buttonTitle1",
                        "buttonTitle2"
                    ],
                    "required": true
                ], [
                    "id": "questionID4",
                    "title": "questionTitle",
                    "type": "multipleChoice",
                    "values": [
                        "buttonTitle1",
                        "buttonTitle2"
                    ],
                    "required": true
                ], [
                    "id": "questionID5",
                    "title": "questionTitle",
                    "type": "dropDown",
                    "values": [
                        "buttonTitle1",
                        "buttonTitle2"
                    ],
                    "required": true
                ], [
                    "id": "questionID6",
                    "title": "questionTitle",
                    "type": "linearScale",
                    "maxValue": 5,
                    "minValue": 0,
                    "required": true
                ]
            ]
        ]
        
        self.testModelSectionByJson(Section.build(json1)!, json: json1)
        
        // Error Handle Miss ID
        let json2: JSON = [
            "title": "sectionTitle",
            "description": "sectionDescription",
            "questions": [
                [
                    "id": "questionID1",
                    "title": "questionTitle",
                    "type": "shortAnswer",
                    "placeholder": "placeholder",
                    "required": true
                ], [
                    "id": "questionID2",
                    "title": "questionTitle",
                    "type": "paragraph",
                    "placeholder": "placeholder",
                    "required": false
                ], [
                    "id": "questionID3",
                    "title": "questionTitle",
                    "type": "checkBoxes",
                    "values": [
                        "buttonTitle1",
                        "buttonTitle2"
                    ],
                    "required": true
                ], [
                    "id": "questionID4",
                    "title": "questionTitle",
                    "type": "multipleChoice",
                    "values": [
                        "buttonTitle1",
                        "buttonTitle2"
                    ],
                    "required": true
                ], [
                    "id": "questionID5",
                    "title": "questionTitle",
                    "type": "dropDown",
                    "values": [
                        "buttonTitle1",
                        "buttonTitle2"
                    ],
                    "required": true
                ], [
                    "id": "questionID6",
                    "title": "questionTitle",
                    "type": "linearScale",
                    "maxValue": 5,
                    "minValue": 0,
                    "required": true
                ]
            ]
        ]
        
        if Section.build(json2) != nil {
            XCTFail()
        }
    }
    
    func testModelSectionByJson(section: Section, json: JSON) {
        // Import
        XCTAssertEqual(section.id, json["id"].string)
        XCTAssertEqual(section.title, json["title"].string)
        XCTAssertEqual(section.description, json["description"].string)
        
        for i in 0 ..< section.questions.count {
            let question = section.questions[i]
            
            switch question.type {
            case .ShortAnswer:
                self.testModelShortAnswerByJson(question as! ShortAnswer, json: json["questions"].array![i])
                break
            case .Paragraph:
                self.testModelParagraphByJson(question as! Paragraph, json: json["questions"].array![i])
                break
            case .CheckBoxes:
                self.testModelCheckBoxesByJson(question as! CheckBoxes, json: json["questions"].array![i])
                break
            case .MultipleChoice:
                self.testModelMultipleChoiceByJson(question as! MultipleChoice, json: json["questions"].array![i])
                break
            case .DropDown:
                self.testModelDropDownByJson(question as! DropDown, json: json["questions"].array![i])
                break
            case .LinearScale:
                self.testModelLinearScaleByJson(question as! LinearScale, json: json["questions"].array![i])
                break
            }
        }
        
        // Export
        let output = section.json()
        
        XCTAssertEqual(output["id"].string, json["id"].string)
        XCTAssertEqual(output["title"].string, json["title"].string)
        XCTAssertEqual(output["description"].string, json["description"].string)
        
        for i in 0 ..< output["questions"].arrayValue.count {
            let question = output["questions"].arrayValue[i]
            
            switch question["type"].stringValue {
            case QuestionType.ShortAnswer.rawValue:
                self.testModelShortAnswerByJson(ShortAnswer.build(question)!, json: json["questions"].array![i])
                break
            case QuestionType.Paragraph.rawValue:
                self.testModelParagraphByJson(Paragraph.build(question)!, json: json["questions"].array![i])
                break
            case QuestionType.CheckBoxes.rawValue:
                self.testModelCheckBoxesByJson(CheckBoxes.build(question)!, json: json["questions"].array![i])
                break
            case QuestionType.MultipleChoice.rawValue:
                self.testModelMultipleChoiceByJson(MultipleChoice.build(question)!, json: json["questions"].array![i])
                break
            case QuestionType.DropDown.rawValue:
                self.testModelDropDownByJson(DropDown.build(question)!, json: json["questions"].array![i])
                break
            case QuestionType.LinearScale.rawValue:
                self.testModelLinearScaleByJson(LinearScale.build(question)!, json: json["questions"].array![i])
                break
            default:
                break
            }
        }
    }
    
    func testModelForm() {
        let json1: JSON = [
            "id": "formID1",
            "title": "formTitle",
            "sections": [
                [
                    "id": "sectionID1",
                    "title": "sectionTitle",
                    "description": "sectionDescription",
                    "questions": [
                        [
                            "id": "questionID1",
                            "title": "questionTitle",
                            "type": "shortAnswer",
                            "placeholder": "placeholder",
                            "required": true
                        ], [
                            "id": "questionID2",
                            "title": "questionTitle",
                            "type": "paragraph",
                            "placeholder": "placeholder",
                            "required": false
                        ], [
                            "id": "questionID3",
                            "title": "questionTitle",
                            "type": "checkBoxes",
                            "values": [
                                "buttonTitle1",
                                "buttonTitle2"
                            ],
                            "required": true
                        ]
                    ]
                ], [
                    "id": "sectionID2",
                    "title": "sectionTitle",
                    "description": "sectionDescription",
                    "questions": [
                        [
                            "id": "questionID1",
                            "title": "questionTitle",
                            "type": "shortAnswer",
                            "placeholder": "placeholder",
                            "required": true
                        ]
                    ]
                ]
            ]
        ]
        
        self.testModelFormByJson(Form.build(json1)!, json: json1)
        
        let json2 = getJsonFormByFile()
        
        self.testModelFormByJson(Form.build(json2)!, json: json2)
    }
    
    func getJsonFormByFile() -> JSON {
        if let path = NSBundle.mainBundle().pathForResource("FormStruct", ofType: "json") {
            if let jsonData = NSData(contentsOfFile: path) {
                return JSON(data: jsonData)
            }
        }
        return nil
    }
    
    func testModelFormByJson(form: Form, json: JSON) {
        // Import
        XCTAssertEqual(form.id, json["id"].string)
        XCTAssertEqual(form.title, json["title"].string)
        
        for i in 0 ..< form.sections.count {
            let section = form.sections[i]
            
            self.testModelSectionByJson(section, json: json["sections"].array![i])
        }
        
        // Export
        let output = form.json()
        
        XCTAssertEqual(output["id"].string, json["id"].string)
        XCTAssertEqual(output["title"].string, json["title"].string)
        
        for i in 0 ..< output["sections"].arrayValue.count {
            let section = output["sections"].arrayValue[i]
            
            self.testModelSectionByJson(Section.build(section)!, json: json["sections"].array![i])
        }
    }
    
}

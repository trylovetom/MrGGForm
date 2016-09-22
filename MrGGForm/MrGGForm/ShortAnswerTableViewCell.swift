//
//  ShortAnswerTableViewCell.swift
//  MrGGForm
//
//  Created by 張子晏 on 2016/6/5.
//  Copyright © 2016年 張子晏. All rights reserved.
//

import UIKit
import SteviaLayout

protocol ShortAnswerTableViewCellProtocol {
    func shortAnswerDidEndEditing(id: String, content: String)
}

class ShortAnswerTableViewCell: UITableViewCell, UITextFieldDelegate {
    let textField = UITextField()
    let titleLabel = UILabel()
    var delegate: ShortAnswerTableViewCellProtocol?
    let shortAnswer: ShortAnswer
    
    // MARK: - Initializer
    init(shortAnswer: ShortAnswer) {
        self.shortAnswer = shortAnswer
        super.init(style: .Default, reuseIdentifier: QuestionType.ShortAnswer.rawValue)
        textField.placeholder = shortAnswer.placeholder
        titleLabel.text = shortAnswer.title
        textField.delegate = self
        textField.returnKeyType = .Done
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Render
    override func drawRect(rect: CGRect) {
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 5.0
        textField.layer.masksToBounds = true
        sv(textField, titleLabel)
        layout(
            8,
            |-titleLabel-|,
            |-20-textField-20-|,
            8
        )
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if let text = textField.text {
            delegate?.shortAnswerDidEndEditing(shortAnswer.id, content: text)
        }
    }
}

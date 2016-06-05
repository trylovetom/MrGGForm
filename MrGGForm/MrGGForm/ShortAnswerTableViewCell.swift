//
//  ShortAnswerTableViewCell.swift
//  MrGGForm
//
//  Created by 張子晏 on 2016/6/5.
//  Copyright © 2016年 張子晏. All rights reserved.
//

import UIKit
import SteviaLayout

class ShortAnswerTableViewCell: UITableViewCell {
    let textField = UITextField()
    let titleLabel = UILabel()
    let shortAnswer: ShortAnswer
    
    // MARK: - Initializer
    init(shortAnswer: ShortAnswer) {
        self.shortAnswer = shortAnswer
        super.init(style: .Default, reuseIdentifier: QuestionType.ShortAnswer.rawValue)
        textField.placeholder = shortAnswer.placeholder
        titleLabel.text = shortAnswer.title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARM: - Render
    override func drawRect(rect: CGRect) {
        sv(textField, titleLabel)
        layout(
            8,
            |-titleLabel-|,
            |-20-textField-20-|,
            8
        )
    }
}

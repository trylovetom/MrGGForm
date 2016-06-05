//
//  ParagraphTableViewCell.swift
//  MrGGForm
//
//  Created by 張子晏 on 2016/6/5.
//  Copyright © 2016年 張子晏. All rights reserved.
//

import UIKit
import SteviaLayout

class ParagraphTableViewCell: UITableViewCell {
    let titleLabel = UILabel()
    let textView = UITextView()
    let paragraph: Paragraph
    
    
    // MARK: - Initializer
    init(paragraph: Paragraph) {
        self.paragraph = paragraph
        super.init(style: .Default, reuseIdentifier: QuestionType.Paragraph.rawValue)
        titleLabel.text = paragraph.title
        textView.text = paragraph.placeholder
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Render
    override func drawRect(rect: CGRect) {
        sv(titleLabel, textView)
        layout(
            8,
            |-titleLabel-|,
            |-20-textView-20-|,
            8
        )
    }
}

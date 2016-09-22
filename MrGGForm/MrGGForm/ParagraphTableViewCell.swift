//
//  ParagraphTableViewCell.swift
//  MrGGForm
//
//  Created by 張子晏 on 2016/6/5.
//  Copyright © 2016年 張子晏. All rights reserved.
//

import UIKit
import SteviaLayout

protocol ParagraphTableViewCellProtocol {
    func paragraphDidEndEditing(id: String, content: [String])
}

class ParagraphTableViewCell: UITableViewCell, UITextViewDelegate {
    let titleLabel = UILabel()
    let textView = UITextView()
    let paragraph: Paragraph
    var delegate: ParagraphTableViewCellProtocol?
    
    // MARK: - Initializer
    init(paragraph: Paragraph) {
        self.paragraph = paragraph
        super.init(style: .Default, reuseIdentifier: QuestionType.Paragraph.rawValue)
        titleLabel.text = paragraph.title
        textView.text = paragraph.placeholder
        textView.delegate = self
        
        let toolbar = UIToolbar()
        toolbar.bounds = CGRectMake(0, 0, 320, 50)
        toolbar.sizeToFit()
        toolbar.barStyle = UIBarStyle.Default
        toolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: self, action: nil),
            UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(ParagraphTableViewCell.handleDone))
        ]
        
        self.textView.inputAccessoryView = toolbar
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Render
    override func drawRect(rect: CGRect) {
        textView.layer.borderWidth = 1.0
        textView.layer.cornerRadius = 3.0
        textView.layer.masksToBounds = true
        sv(titleLabel, textView)
        layout(
            8,
            |-titleLabel-|,
            4,
            |-20-textView-20-|,
            8
        )
    }
    
    // MARK: - Done Action
    func handleDone() {
        textView.resignFirstResponder()
    }
    
    // MARK: - UITextViewDelegate
    func textViewDidEndEditing(textView: UITextView) {
        var content = [String]()
        
        textView.text.enumerateLines({ (line, stop) -> () in
            content.append(line)
        })
        delegate?.paragraphDidEndEditing(paragraph.id, content: content)
    }
}

//
//  MultipleChoiceTableView.swift
//  MrGGForm
//
//  Created by 張子晏 on 2016/6/5.
//  Copyright © 2016年 張子晏. All rights reserved.
//

import UIKit
import SteviaLayout

class MultipleChoiceTableView: UITableViewCell {
    let titleLabel = UILabel()
    var buttons = [UIButton]()
    let multiple: MultipleChoice
    var value = -1 // -1 is none
    
    // MARK: - Initializer
    init(multiple: MultipleChoice) {
        self.multiple = multiple
        super.init(style: .Default, reuseIdentifier: QuestionType.CheckBoxes.rawValue)
        titleLabel.text = multiple.title
        for i in 0 ..< multiple.values.count {
            let button = UIButton(type: .Custom)
            
            button.setTitle(multiple.values[i], forState: .Normal)
            buttons.append(button)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Render
    override func drawRect(rect: CGRect) {
        sv(titleLabel)
        sv(buttons)
        
        layout(
            8,
            |-titleLabel-|
        )
        
        var lastButton: UIButton?
        var currentButton: UIButton
        
        for i in 0 ..< buttons.count {
            currentButton = buttons[i]
            
            currentButton.layer.borderWidth = 1.0
            currentButton.layer.cornerRadius = 3.0
            currentButton.layer.masksToBounds = true
            
            if i == 0 { // First
                layout(
                    titleLabel,
                    8,
                    |-20-currentButton.width(200)
                )
            } else if i == buttons.count - 1 { // Last
                if lastButton != nil {
                    layout(
                        lastButton!,
                        8,
                        |-20-currentButton.width(200),
                        8
                    )
                }
            } else { // Mid
                if lastButton != nil {
                    layout(
                        lastButton!,
                        8,
                        |-20-currentButton.width(200)
                    )
                }
            }
            currentButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
            currentButton.setTitleColor(UIColor.orangeColor(), forState: .Selected)
            currentButton.tag = i
            currentButton.addTarget(self, action: #selector(MultipleChoiceTableView.buttonAction(_:)), forControlEvents: .TouchUpInside)
            
            // Update Last
            lastButton = currentButton
        }
    }
    
    // MARK: - Action
    func buttonAction(sender: UIButton) {
        value = sender.tag
        for button in buttons {
            button.selected = false
        }
        sender.selected = true
    }
}

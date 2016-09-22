//
//  CheckBoxesTableViewCell.swift
//  MrGGForm
//
//  Created by 張子晏 on 2016/6/5.
//  Copyright © 2016年 張子晏. All rights reserved.
//

import UIKit
import SteviaLayout

protocol CheckBoxesProtocol {
    func checkBoxesDidEndEditing(id: String, content: String)
}

class CheckBoxesTableViewCell: UITableViewCell {
    let titleLabel = UILabel()
    var switches = [UISwitch]()
    var switchesLabel = [UILabel]()
    let checkBoxes: CheckBoxes
    var delegate: CheckBoxesProtocol?
    
    // MARK: - Initializer
    init(checkBoxes: CheckBoxes) {
        self.checkBoxes = checkBoxes
        super.init(style: .Default, reuseIdentifier: QuestionType.CheckBoxes.rawValue)
        titleLabel.text = checkBoxes.title
        for i in 0 ..< checkBoxes.values.count {
            switches.append(UISwitch())
            switchesLabel.append(UILabel())
            switchesLabel[i].text = checkBoxes.values[i]
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Render
    override func drawRect(rect: CGRect) {
        sv(titleLabel)
        sv(switchesLabel)
        sv(switches)
        
        layout(
            8,
            |-titleLabel-|
        )
        
        var lastSwitch: UISwitch?
        var currentSwitch: UISwitch
        var currentLabel: UILabel
        
        for i in 0 ..< switches.count {
            currentSwitch = switches[i]
            currentLabel = switchesLabel[i]
            
            if i == 0 { // First
                layout(
                    titleLabel,
                    8,
                    |-20-currentSwitch-10-currentLabel-20-|
                )
            } else if i == switchesLabel.count - 1 { // Last
                if lastSwitch != nil {
                    layout(
                        lastSwitch!,
                        8,
                        |-20-currentSwitch-10-currentLabel-20-|,
                        8
                    )
                }
            } else { // Mid
                if lastSwitch != nil {
                    layout(
                        lastSwitch!,
                        8,
                        |-20-currentSwitch-10-currentLabel-20-|
                    )
                }
            }
            currentLabel.center = currentSwitch.center
            currentSwitch.addTarget(self, action: #selector(CheckBoxesTableViewCell.switchAction(_:)), forControlEvents: .ValueChanged)
            currentSwitch.tag = i
            
            // Update Last
            lastSwitch = currentSwitch
        }
    }
    
    // MARK: - Action
    func switchAction(sender: UISwitch) {
        var string = ""
        
        for (i, currentSwitch) in switches.enumerate() {
            if currentSwitch.on {
                string = string.stringByAppendingString(checkBoxes.values[i] + "\n")
            }
        }
        
        delegate?.checkBoxesDidEndEditing(checkBoxes.id, content: string)
    }
}

//
//  DropDownTableViewCell.swift
//  MrGGForm
//
//  Created by 張子晏 on 2016/6/5.
//  Copyright © 2016年 張子晏. All rights reserved.
//

import UIKit
import SteviaLayout

class DropDownTableViewCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource {
    let titleLabel = UILabel()
    let pickerView = UIPickerView()
    let value = -1
    let dropDown: DropDown
    
    // MARK: - Initializer
    init(dropDown: DropDown) {
        self.dropDown = dropDown
        super.init(style: .Default, reuseIdentifier: QuestionType.DropDown.rawValue)
        self.titleLabel.text = dropDown.title
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARM: - Render
    override func drawRect(rect: CGRect) {
        sv(titleLabel, pickerView)
        layout(
            8,
            |-titleLabel-|,
            |-50-pickerView-50-|,
            8
        )
    }
    
    // MARM: - UIPickerViewDelegate
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dropDown.values[row]
    }
    
    // MARM: -  UIPickerViewDataSource
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dropDown.values.count
    }
}

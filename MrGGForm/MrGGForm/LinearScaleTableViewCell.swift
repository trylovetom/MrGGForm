//
//  LinearScaleTableViewCell.swift
//  MrGGForm
//
//  Created by 張子晏 on 2016/6/5.
//  Copyright © 2016年 張子晏. All rights reserved.
//

import UIKit
import SteviaLayout

class LinearScaleTableViewCell: UITableViewCell {
    let slider = UISlider()
    let titleLabel = UILabel()
    let minLabel = UILabel()
    let maxLabel = UILabel()
    let currentLabel = UILabel()
    let linearScale: LinearScale
    var value: Float = 0
    
    // MARK: - Initializer
    init(linearScale: LinearScale) {
        self.linearScale = linearScale
        super.init(style: .Default, reuseIdentifier: QuestionType.LinearScale.rawValue)
        titleLabel.text = linearScale.title
        slider.maximumValue = linearScale.maxValue.floatValue
        slider.minimumValue = linearScale.minValue.floatValue
        minLabel.text = linearScale.minValue.stringValue
        maxLabel.text = linearScale.maxValue.stringValue
        currentLabel.text = "0"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Render
    override func drawRect(rect: CGRect) {
        sv(titleLabel, slider, minLabel, maxLabel, currentLabel)
        layout(
            8,
            |-titleLabel-currentLabel-|,
            |-20-minLabel-slider-maxLabel-20-|,
            16
        )
        slider.continuous = false
        slider.addTarget(self, action: #selector(LinearScaleTableViewCell.sliderAction), forControlEvents: .ValueChanged)
    }
    
    // MARK: - Action
    func sliderAction() {
        if (slider.value < value) {
            slider.value = Float(Int(slider.value - 0.5))
        } else {
            slider.value = Float(Int(slider.value + 0.5))
        }
        currentLabel.text = String(slider.value)
    }
}

//
//  AddQuestionViewController.swift
//  MrGGForm
//
//  Created by 張子晏 on 2016/6/15.
//  Copyright © 2016年 張子晏. All rights reserved.
//

import UIKit
import SteviaLayout

class AddQuestionViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    // View
    let pickerView = UIPickerView()
    let idLabel = UILabel()
    let idTextField = UITextField()
    let titleLabel = UILabel()
    let titleTextField = UITextField()
    let scrollView = UIScrollView()
    
    // Scroll View
    let placeholderTextField = UITextField()
    
    // MARK: - Initializer
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pickerView.delegate = self
        pickerView.dataSource = self
        idTextField.delegate = self
        titleTextField.delegate = self
        placeholderTextField.delegate = self
        render()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Render
    func render() {
        // View
        view.backgroundColor = UIColor.whiteColor()
        view.sv(pickerView, scrollView, idTextField, titleTextField, titleLabel, idLabel)
        view.layout(
            0,
            |-pickerView-|,
            8,
            |-idLabel-|,
            8,
            |-idTextField.centerHorizontally()-|,
            8,
            |-titleLabel-|,
            8,
            |-titleTextField.centerHorizontally()-|,
            8,
            |-scrollView-|,
            0
        )
        
        // Scroll View
        scrollView.backgroundColor = UIColor.brownColor()
        idTextField.backgroundColor = UIColor.blueColor()
        placeholderTextField.backgroundColor = UIColor.darkGrayColor()
        //        titleTextField.removeConstraints(titleTextField.constraints)
        
//        scrollView.sv(idTextField, titleTextField)
//        scrollView.layout(
//        )
//        
//        let number = pickerView.selectedRowInComponent(0)
//        
//        switch number {
//        case QuestionType.ShortAnswer.hashValue, QuestionType.Paragraph.hashValue:
//            scrollView.sv(placeholderTextField)
//            scrollView.layout(
//                |-titleTextField-|,
//                8,
//                |-placeholderTextField.centerHorizontally()-|,
//                8
//            )
//        default:
//            placeholderTextField.removeFromSuperview()
//            scrollView.layout(
//                |-titleTextField-|,
//                8
//            )
//        }
        
        
        
        titleTextField.backgroundColor = UIColor.orangeColor()
        idLabel.text = "ID:"
        titleLabel.text = "Title:"
        idTextField.returnKeyType = .Done
        titleTextField.returnKeyType = .Done
    }
    
    // MARK: - TextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - UIPickerViewDelegate
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch row {
        case 0:
            return QuestionType.ShortAnswer.rawValue
        case 1:
            return QuestionType.Paragraph.rawValue
        case 2:
            return QuestionType.CheckBoxes.rawValue
        case 3:
            return QuestionType.MultipleChoice.rawValue
        case 4:
            return QuestionType.DropDown.rawValue
        case 5:
            return QuestionType.LinearScale.rawValue
        default:
            return nil
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch row {
        case QuestionType.ShortAnswer.hashValue, QuestionType.Paragraph.hashValue:
            scrollView.addSubview(placeholderTextField)
        default:
            placeholderTextField.removeFromSuperview()
        }
    }
    
    // MARK: - UIPickerViewDataSource
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return QuestionType.count
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

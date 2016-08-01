//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by Giovanni Catania on 18/04/16.
//  Copyright © 2016 Giovanni Catania. All rights reserved.
//

import UIKit

class ConversionViewController : UIViewController, UITextFieldDelegate {
    
    // MARK: - Properties

    @IBOutlet var celsiusLabel : UILabel!
    
    @IBOutlet var textField : UITextField!
    
    var fahrenheitValue : Double? {
        didSet {
            updateCelsiusLabel()
        }
    }
    
    var celsiusValue : Double? {
        if let value = fahrenheitValue {
            return (value - 32) * (5/9)
        } else {
            return nil
        }
    }
    
    let numberFormatter : NSNumberFormatter = {
        let nf = NSNumberFormatter()
        nf.numberStyle = .DecimalStyle
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()

    // MARK: - Methods

    @IBAction func fahrenheitFieldEditingChanged (textField: UITextField) {
        if let text = textField.text, number = numberFormatter.numberFromString(text) {
            fahrenheitValue = number.doubleValue
        } else {
            fahrenheitValue = nil
        }
    }
    
    @IBAction func dismissKeyboard (sender: AnyObject) {
         textField.resignFirstResponder()
    }
    
    func updateCelsiusLabel () {

        if let value = celsiusValue {
            celsiusLabel.text = numberFormatter.stringFromNumber(value)
        } else {
            celsiusLabel.text = "???"
        }
    }
    
    // MARK: - Superclass methods override section
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ConversionViewController loaded its view.")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        func isNight() -> Bool {
            let date = NSDate()
            print (date.hour())
            if date.hour() > 6 && date.hour() < 20 {
                return false
            } else {
                return true
            }
        }
        self.view.backgroundColor = isNight() ? UIColor.blueColor() : UIColor.lightGrayColor()
    }
    
    // MARK: - Delegate funcs
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let currentLocale = NSLocale.currentLocale()
        let decimalSeparator = currentLocale.objectForKey(NSLocaleDecimalSeparator) as! String
        let existingTextHasDecimalSeparator = textField.text?.rangeOfString(decimalSeparator)
        let replacementTextHasDecimalSeparator = string.rangeOfString(decimalSeparator)
        let groupingSeparator = currentLocale.objectForKey(NSLocaleGroupingSeparator) as! String
        let replacementTextHasGroupingSeparator = string.rangeOfString(groupingSeparator)
        
        if replacementTextHasGroupingSeparator != nil {
            return false
        }

        let abc = NSCharacterSet.letterCharacterSet()
        let replacementTextHasLetter = string.rangeOfCharacterFromSet(abc)

        if replacementTextHasLetter != nil {
            return false
        }
        
        if existingTextHasDecimalSeparator != nil && replacementTextHasDecimalSeparator != nil {
            return false
        } else {
            return true
        }
    }
}

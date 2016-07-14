//
//  ValidatorViewController.swift
//  animated-validator-swift
//
//  Created by Flatiron School on 6/27/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ValidatorViewController: UIViewController, UITextFieldDelegate {
	
	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var emailConfirmationTextField: UITextField!
	@IBOutlet weak var phoneTextField: UITextField!
	@IBOutlet weak var submitButton: UIButton!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var passwordConfirmTextField: UITextField!
	
	@IBOutlet weak var buttonBottomLayoutConstraint: NSLayoutConstraint!
	
	
	var allValid: Bool = false
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view, typically from a nib.
		self.submitButton.accessibilityLabel = Constants.SUBMITBUTTON
		self.emailTextField.accessibilityLabel = Constants.EMAILTEXTFIELD
		self.emailConfirmationTextField.accessibilityLabel = Constants.EMAILCONFIRMTEXTFIELD
		self.phoneTextField.accessibilityLabel = Constants.PHONETEXTFIELD
		self.passwordTextField.accessibilityLabel = Constants.PASSWORDTEXTFIELD
		self.passwordConfirmTextField.accessibilityLabel = Constants.PASSWORDCONFIRMTEXTFIELD
		
		self.submitButton.enabled = false
		
		self.emailTextField.delegate = self
		self.emailConfirmationTextField.delegate = self
		self.phoneTextField.delegate = self
		self.passwordTextField.delegate = self
		self.passwordConfirmTextField.delegate = self
		
	}
	
	
	func textFieldShouldEndEditing(textField: UITextField) -> Bool {
		
		let shouldReturn: Bool
		
		guard let text = textField.text else { return false }
		
		switch textField {
		case self.emailTextField:
			shouldReturn = text.containsString("@") && text.containsString(".")
			
		case self.emailConfirmationTextField:
			guard let original = self.emailTextField.text else { return false }
			shouldReturn = text == original
			
		case self.phoneTextField:
			shouldReturn = Int(text) != nil && text.characters.count >= 7
			
		case self.passwordTextField:
			shouldReturn = text.characters.count >= 6
			
		case self.passwordConfirmTextField:
			guard let originalPassword = self.passwordTextField.text else { return false }
			shouldReturn = text == originalPassword
			
		default: shouldReturn = false
		}
		
		if !shouldReturn {
			// pulse textfield
			pulseTextField(textField)
		}
		else {
			checkAllTextFields()
		}
		
		return shouldReturn
	}
	
	func pulseTextField(textfield: UITextField) {
		print("animate stuff")
		
		UIView.animateWithDuration(0.1, delay: 0, options: [.Repeat, .Autoreverse], animations: {
			
			UIView.setAnimationRepeatCount(3)
			
			textfield.backgroundColor = UIColor.redColor()
			textfield.transform = CGAffineTransformMakeScale(0.90, 0.90)
			self.view.layoutIfNeeded()
			
			}) { (completed) in
				textfield.backgroundColor = UIColor.whiteColor()
				textfield.transform = CGAffineTransformMakeScale(1.0, 1.0)
				self.view.layoutIfNeeded()
		}
	
	}
	
	func checkAllTextFields() {
		
		let textFields = self.view.subviews.filter { (subview) -> Bool in
			if subview is UITextField {
				let textfield = subview as! UITextField
				return textfield.text?.characters.count > 0
			}
			return false
		}
		
		if textFields.count == 5 {
			// all text fields are filled out
			self.submitButton.enabled = true
			// animate submit button
			animateButton()
		}
	}
	
	func animateButton() {
		UIView.animateWithDuration(1) { 
			self.buttonBottomLayoutConstraint.constant = 400
			self.view.layoutIfNeeded()
		}
	}
	
	
}
//
//  testViewController.swift
//  yogurbox.v1
//
//  Created by 王麟 on 15/11/18.
//  Copyright © 2015年 dtynn. All rights reserved.
//

import UIKit

func YBGetKeyboardRect(notification: NSNotification) -> CGRect? {
    return (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue()
}

class rootViewController: UIViewController {
    private var keyboardHeight: CGFloat = 0
    
    private var mainView: IView!
    private var wrapper: IView!
    private var logoView: IView!
    private var switchButton: IButton!
    private var aliasInput: IInput!
    private var passwordInput: IInput!
    private var submitButton: IButton!
    
    private var aliasValid: Bool = false
    private var passwordValid: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillChangeFrame:", name: UIKeyboardWillChangeFrameNotification, object: nil)
        
        mainView = IView.namedView("signinView.html")
        wrapper = mainView.getViewById("wrapper")
        
        logoView = mainView.getViewById("logo")
        switchButton = mainView.getViewById("switchButton") as! IButton
        
        aliasInput = mainView.getViewById("aliasInput") as! IInput
        aliasInput.textField.keyboardType = .ASCIICapable
        aliasInput.textField.spellCheckingType = .No
        aliasInput.textField.autocorrectionType = .No
        aliasInput.textField.autocapitalizationType = .None
        
        aliasInput.textField.returnKeyType = .Next
        aliasInput.addEvent(IEventReturn) { (ievent, iview) -> Void in
            self.passwordInput.textField.becomeFirstResponder()
        }
        aliasInput.addEvent(IEventChange) { (ievent, iview) -> Void in
            self.validate()
        }
        
        passwordInput = mainView.getViewById("passwordInput") as! IInput
        passwordInput.textField.returnKeyType = .Go
        passwordInput.addEvent(IEventChange) { (ievent, iview) -> Void in
            self.validate()
        }
        passwordInput.addEvent(IEventReturn) { (ievent, iview) -> Void in
            // try submit
            if self.aliasValid && self.passwordValid {
                self.doSignin()
            }
        }
        
        submitButton = mainView.getViewById("submitButton") as! IButton
        submitButton.addEvent(IEventClick) { (ievent, iview) -> Void in
            self.doSignin()
        }
        
        self.validate()
        
        self.view.addSubview(mainView)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.aliasInput.textField.becomeFirstResponder()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    func keyboardWillChangeFrame(notification: NSNotification) {
        if let keyboardSize = YBGetKeyboardRect(notification) {
            if keyboardSize.height != keyboardHeight {
                self.keyboardHeight = keyboardSize.height
                self.wrapper.style.set(String(format: "margin-bottom: %.01fpx;", self.keyboardHeight))
            }
        }
    }
    
    private func validate() {
        let alias = self.aliasInput.textField.text
        self.aliasValid = alias != nil && alias != ""
        
        let password = self.passwordInput.textField.text
        self.passwordValid = password != nil && password != ""
        
        self.submitButton.button.enabled = self.aliasValid && self.passwordValid
    }
    
    private func doSignin() {
        NSLog("signin with alias: \n%@ \nand password:\n%@", self.aliasInput.textField.text!, self.passwordInput.textField.text!)
    }
}

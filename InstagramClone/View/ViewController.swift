//
//  ViewController.swift
//  InstagramClone
//
//  Created by Barış Can Akkaya on 27.09.2021.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        
    }

    @IBAction func loginClicked(_ sender: UIButton) {
        performSegue(withIdentifier: "goToMain", sender: self)
    }
    
    @IBAction func signUpClicked(_ sender: UIButton) {
        performSegue(withIdentifier: "goToRegister", sender: self)
    }
    
    func setLayout(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        getWidthAndHeight()
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(screenHeight * 0.07)
            make.width.equalTo(screenWidth * 0.75)
            make.top.equalTo(screenHeight * 0.15)
        }
        usernameTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(screenHeight * 0.065)
            make.width.equalTo(screenWidth * 0.75)
            make.top.equalTo(self.label).offset(screenHeight * 0.3)
        }
        passwordTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(screenHeight * 0.065)
            make.width.equalTo(screenWidth * 0.75)
            make.top.equalTo(self.usernameTextField).offset(screenHeight * 0.1)
        }
        loginButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(screenHeight * 0.07)
            make.width.equalTo(screenWidth * 0.75)
            make.top.equalTo(self.passwordTextField).offset(screenHeight * 0.15)
        }
        signupButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(screenHeight * 0.07)
            make.width.equalTo(screenWidth * 0.75)
            make.top.equalTo(self.loginButton).offset(screenHeight * 0.1)
        }
    }
    
    func getWidthAndHeight(){
        //self.frame.size.width
        //self.frame.size.height
        screenWidth = UIScreen.main.bounds.width
        screenHeight = UIScreen.main.bounds.height
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}


//
//  ViewController.swift
//  InstagramClone
//
//  Created by Barış Can Akkaya on 27.09.2021.
//

import UIKit
import SnapKit
import Firebase

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
        if usernameTextField.text != "" && passwordTextField.text != "" {
            Auth.auth().signIn(withEmail: usernameTextField.text!, password: passwordTextField.text!) { result, error in
                if let error = error {
                    self.callAlert(message: error.localizedDescription)
                } else {
                    self.performSegue(withIdentifier: "goToMain", sender: self)
                }
            }
        } else {
            callAlert(message: "Invalid email or password")
        }
    }
    
    @IBAction func signUpClicked(_ sender: UIButton) {
        if usernameTextField.text != "" && passwordTextField.text != "" {
            Auth.auth().createUser(withEmail: usernameTextField.text!, password: passwordTextField.text!) { result, error in
                if let error = error {
                    self.callAlert(message: error.localizedDescription)
                } else {
                    self.performSegue(withIdentifier: "goToMain", sender: self)
                }
            }
        } else {
            callAlert(message: "Invalid email or password")
        }
    }
    
}
extension ViewController {
    func setLayout(){
        closeKeyboard()
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
        //loginButton.hero.id = "LoginButton"
        
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
    
    func callAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let button = UIAlertAction(title: "OK!", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(button)
        self.present(alert, animated: true, completion: nil)
    }
    func closeKeyboard(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}




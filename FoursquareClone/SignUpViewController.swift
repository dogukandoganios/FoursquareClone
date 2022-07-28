//
//  ViewController.swift
//  FoursquareClone
//
//  Created by Doğukan Doğan on 26.07.2022.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {
    
    var foursquareLabel = UILabel()
    var nameTextFiled = UITextField()
    var passwordTextField = UITextField()
    var loginButton = UIButton()
    var singupButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        overrideUserInterfaceStyle = .light
        
        let width = view.frame.size.width
        let height = view.frame.size.height
        
        foursquareLabel.text = "Foursquare Clone"
        foursquareLabel.textAlignment = .center
        foursquareLabel.font = UIFont(name: foursquareLabel.font.fontName, size: 30)
        foursquareLabel.frame = CGRect(x: width  * 0.5 - width * 0.8 / 2, y: height * 0.15 - height * 0.1 / 2, width: width * 0.8, height: height * 0.1)
        view.addSubview(foursquareLabel)
        
        nameTextFiled.attributedPlaceholder = NSAttributedString(string: "User Name", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray.withAlphaComponent(0.5)])
        nameTextFiled.layer.borderWidth = 1
        nameTextFiled.layer.borderColor = UIColor.black.cgColor
        nameTextFiled.textAlignment = .center
        nameTextFiled.frame = CGRect(x: width * 0.5 - width * 0.65 / 2, y: height * 0.25 - height * 0.05 / 2, width: width * 0.65, height: height * 0.05)
        view.addSubview(nameTextFiled)
        
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray.withAlphaComponent(0.5)])
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = UIColor.black.cgColor
        passwordTextField.textAlignment = .center
        passwordTextField.frame = CGRect(x: width * 0.5 - width * 0.65 / 2, y: height * 0.32 - height * 0.05 / 2, width: width * 0.65, height: height * 0.05)
        view.addSubview(passwordTextField)
        
        loginButton.setTitle("Sing In", for: UIControl.State.normal)
        loginButton.setTitleColor(UIColor.blue, for: UIControl.State.normal)
        loginButton.frame = CGRect(x: width * 0.25 - width * 0.16 / 2, y: height * 0.39 - height * 0.05 / 2, width: width * 0.16, height: height * 0.05)
        loginButton.addTarget(self, action: #selector(loginClick), for: UIControl.Event.touchUpInside)
        view.addSubview(loginButton)
        
        singupButton.setTitle("Sing Up", for: UIControl.State.normal)
        singupButton.setTitleColor(UIColor.blue, for: UIControl.State.normal)
        singupButton.frame = CGRect(x: width * 0.75 - width * 0.16 / 2, y: height * 0.39 - height * 0.05 / 2, width: width * 0.16, height: height * 0.05)
        singupButton.addTarget(self, action: #selector(singupClick), for: UIControl.Event.touchUpInside)
        view.addSubview(singupButton)
        
        
    }
    
    @objc func loginClick(){
        
        if nameTextFiled.text != "" && passwordTextField.text != ""{
            
            PFUser.logInWithUsername(inBackground: nameTextFiled.text!, password: passwordTextField.text!) { user, error in
                
                if error != nil {
                    
                    self.alter(alertTitle: "Error", errorMessage: error?.localizedDescription ?? "Error")
                    
                }else{
                    
                    self.performSegue(withIdentifier: "tofeedView", sender: nil)
                    
                }
                
            }
            
        }else{
            
            self.alter(alertTitle: "Error!", errorMessage: "Name or password not nil!")
            
        }
        
    }
    
    @objc func singupClick(){
        
        if nameTextFiled.text != nil && passwordTextField.text != nil {
            
            let user = PFUser()
            user.username = nameTextFiled.text!
            user.password = passwordTextField.text!
            
            user.signUpInBackground { succed, error in
                
                if error != nil {
                    
                    self.alter(alertTitle: "Error!", errorMessage: error?.localizedDescription ?? "Error")
                    
                }else {
                    
                    self.performSegue(withIdentifier: "tofeedView", sender: nil)
                    
                }
            }
            
        }else{
            
            alter(alertTitle: "Error!", errorMessage: "Name or Password not nil!")
            
        }
    }

    func alter(alertTitle : String, errorMessage : String){
        
        let alert = UIAlertController(title: alertTitle, message: errorMessage, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
        
    }

}


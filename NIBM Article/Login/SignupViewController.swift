//
//  SignupViewController.swift
//  NIBM Article
//
//  Created by Kithmal Bulathsinhala on 11/3/19.
//  Copyright © 2019 NIBM. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignupViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtPass: UITextField!
    
    @IBOutlet weak var txtRePass: UITextField!
    
    
    @IBAction func signupButtonClick(_ sender: Any) {
        var a = false
        var b = false
        
        if txtPass.text == txtRePass.text {
            
            a = true
            
        } else {
            
            self.showAlert(message: "Passwords don't match")
        }
        
        if(txtPass.text == "" || txtRePass.text == "") {
            self.showAlert(message: "Fields cannot be empty")
            
        } else {
            
            b = true
        }
        
        if a == true && b == true {
            
            
            if ((txtEmail.text?.isEmpty)! || (txtPass.text?.isEmpty)!) {
                self.showAlert(message: "All fields are mandatory!")
                return
            } else {
                
                ///////////////////////////////////////////////////////////////////////////////////////////
                let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
                
                let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
                loadingIndicator.hidesWhenStopped = true
                loadingIndicator.style = UIActivityIndicatorView.Style.gray
                loadingIndicator.startAnimating();
                
                alert.view.addSubview(loadingIndicator)
                present(alert, animated: true, completion: nil)
                
                ///////////////////////////////////////////////////////////////////////////////////////////
                
                Auth.auth().createUser(withEmail: txtEmail.text!, password: txtPass.text!) {
                    (authResult, error) in
                    // ...
                    if error == nil {
                        alert.dismiss(animated: false, completion: nil)
                        
                        let vc = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")
                        self.present(vc, animated: true, completion: nil)
                        
                        self.showAlert(message: "Signup Successful!")
                        
                        
                        
                        
                        
                        
                    } else {
                        if let errorCode = AuthErrorCode(rawValue: error!._code) {
                            switch errorCode {
                            case .invalidEmail:
                                alert.dismiss(animated: false, completion: nil)
                                self.showAlert(message: "You entered an invalid email!")
                            case .userNotFound:
                                alert.dismiss(animated: false, completion: nil)
                                self.showAlert(message: "User not found")
                            case .weakPassword:
                                alert.dismiss(animated: false, completion: nil)
                                self.showAlert(message: "Password must have at least 6 charachters")
                            case .emailAlreadyInUse:
                                alert.dismiss(animated: false, completion: nil)
                                self.showAlert(message: "Email already in use")
                            default:
                                alert.dismiss(animated: false, completion: nil)
                                print("Creating user error \(error.debugDescription)!")
                                self.showAlert(message: "Unexpected error \(errorCode.rawValue) please try again!")
                            }
                        }
                    }
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func showAlert(message:String)
    {
        
        let alert = UIAlertController(title: message, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }

}

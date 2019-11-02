//
//  LoginViewController.swift
//  NIBM Article
//
//  Created by Kithmal Bulathsinhala on 10/28/19.
//  Copyright © 2019 NIBM. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPass: UITextField!
    
    
    @IBAction func btnSigninCLicked(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: txtEmail.text!, password: txtPass.text!) { (user, error) in
            // ...
            if(error == nil)
            {
                var user_email:String?
                if let user = user {
                    _ = user.user.displayName
                    user_email = user.user.email
                    print(user_email!)
                }
                
                //self.showAlert(message: "SignIn Successfully! Email: \(user_email!)")
                UserDefaults.standard.set(user_email, forKey: "LoggedUser")
                UserDefaults.standard.set(true, forKey: "LoggedIn")
                UserDefaults.standard.synchronize()
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarController")
                self.present(vc, animated: true, completion: nil)
                
                
                //                let trial = HomeViewController ()
                //                self.navigationController?.pushViewController (trial, animated: true)
                
            }
            else{
                if let errorCode = AuthErrorCode(rawValue: error!._code) {
                    switch errorCode {
                    case.wrongPassword:
                        self.showAlert(message: "You entered an invalid password please try again!")
                        break
                    case.userNotFound:
                        self.showAlert(message: "There is no matching account with that email")
                        break
                    default:
                        self.showAlert(message: "Unexpected error \(errorCode.rawValue) please try again!")
                        print("Creating user error \(error.debugDescription)!")
                    }
                }
            }
        }
    }
    
    func showAlert(message:String)
    {
        let alert = UIAlertController(title: message, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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

}

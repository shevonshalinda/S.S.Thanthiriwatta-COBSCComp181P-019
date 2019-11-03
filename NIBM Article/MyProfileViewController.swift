//
//  MyProfileViewController.swift
//  NIBM Article
//
//  Created by Kithmal Bulathsinhala on 11/3/19.
//  Copyright © 2019 NIBM. All rights reserved.
//

import UIKit

class MyProfileViewController: UIViewController {

    @IBAction func btnSignOut(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "LoggedUser")
        UserDefaults.standard.removeObject(forKey: "LoggedIn")
        let vc = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")
        self.present(vc, animated: true, completion: nil)
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

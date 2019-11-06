//
//  TabbedBarViewController.swift
//  NIBM Article
//
//  Created by Kithmal Bulathsinhala on 11/5/19.
//  Copyright © 2019 NIBM. All rights reserved.
//

import UIKit
import BiometricAuthentication


class TabbedBarViewController:  UITabBarController, UITabBarControllerDelegate {
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        self.delegate = self
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController.isKind(of: MyProfileViewController.self) {
            print("dddddddddddddddddddd")
            BioMetricAuthenticator.authenticateWithBioMetrics(reason: "Authentication required to access this section") { (result) in
                
                switch result {
                case .success( _):
                    print("Authentication Successful")
                    self.selectedIndex = 2
                case .failure(let error):
                    print("Authentication Failed")
                    
                }
            }
//            let vc =  MyProfileViewController()
//            vc.modalPresentationStyle = .overFullScreen
//            self.present(vc, animated: true, completion: nil)
            return false
        }
        return true

    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print("eeeee--\(item.tag)")
        
    }

    
}

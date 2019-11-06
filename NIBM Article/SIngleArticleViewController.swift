//
//  SIngleArticleViewController.swift
//  NIBM Article
//
//  Created by Kithmal Bulathsinhala on 11/3/19.
//  Copyright © 2019 NIBM. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kingfisher

class SIngleArticleViewController: UIViewController {

    
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var imgPhoto: UIImageView!
    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var txtDescription: UILabel!
    
    
    var article: JSON?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(article)
        txtTitle.text = article!["title"].stringValue
        txtDescription.text = article!["description"].stringValue

        let imageURL = URL(string: article!["imageUrl"].stringValue)
        imgPhoto.kf.setImage(with: imageURL)
        
        let avatarURL = URL(string: article!["userAvatarImageUrl"].stringValue)
        imgAvatar.kf.setImage(with: avatarURL)
        
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

//
//  ArticleTableViewCell.swift
//  NIBM Article
//
//  Created by Kithmal Bulathsinhala on 10/30/19.
//  Copyright © 2019 NIBM. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    

    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var imgPhoto: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

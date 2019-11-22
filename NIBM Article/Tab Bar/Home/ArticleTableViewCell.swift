//
//  ArticleTableViewCell.swift
//  NIBM Article
//
//  Created by Kithmal Bulathsinhala on 10/30/19.
//  Copyright © 2019 NIBM. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    


    @IBOutlet weak var imgPhoto: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    
    @IBOutlet weak var avatarBtn: UIButton!
    
    var User : String?
    
    // the delegate, remember to set to weak to prevent cycles
    weak var delegate : ArticleTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // Add action to perform when the button is tapped
        self.avatarBtn.addTarget(self, action: #selector(avatarButtonTapped(_:)), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func avatarButtonTapped(_ sender: UIButton){
        if let user = User,
            let delegate = delegate {
            self.delegate?.avatarTableViewCell(self, avatarButtonTappedFor: user)
        }
    }
    
}

protocol ArticleTableViewCellDelegate: AnyObject {
    func avatarTableViewCell(_ articleTableViewCell: ArticleTableViewCell, avatarButtonTappedFor user: String)
}

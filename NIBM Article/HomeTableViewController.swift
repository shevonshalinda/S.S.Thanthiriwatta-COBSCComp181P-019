//
//  HomeTableViewController.swift
//  NIBM Article
//
//  Created by Kithmal Bulathsinhala on 10/30/19.
//  Copyright © 2019 NIBM. All rights reserved.
//

import UIKit
import FirebaseDatabase
import SwiftyJSON
import Kingfisher

class HomeTableViewController: UITableViewController {
    
    private var items = [JSON](){
        didSet{
            tableView.reloadData()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ArticleTableViewCell", bundle: nil), forCellReuseIdentifier: "ArticleTableViewCell")
        
        
        let ref = Database.database().reference().child("articles")
        ref.observe(.value, with: { snapshot in
            self.items.removeAll()
            let dict = snapshot.value as? [String: AnyObject]
            let json = JSON(dict as Any)

            for object in json["allArticles"]{
                //print(object.1)
                self.items.append(object.1)
            }
        })
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 270
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as! ArticleTableViewCell

        cell.lblTitle.text = items[indexPath.row]["title"].stringValue
        cell.lblDesc.text = items[indexPath.row]["description"].stringValue

        let imageURL = URL(string: items[indexPath.row]["imageUrl"].stringValue)
        cell.imgPhoto.kf.setImage(with: imageURL)

        let avatarImageURL = URL(string: items[indexPath.row]["userAvatarImageUrl"].stringValue)
        cell.imgAvatar.kf.setImage(with: avatarImageURL)
        
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

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
    
    
    func nothingToShow(){
        let lable = UILabel(frame: .zero)
        lable.textColor = UIColor.darkGray
        lable.numberOfLines = 0
        lable.text = "Oops, /n No articles to show"
        lable.textAlignment = .center
        tableView.separatorStyle = .none
        tableView.backgroundView = lable
    }
}

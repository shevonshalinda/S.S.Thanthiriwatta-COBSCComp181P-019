//
//  CreatNewPostViewController.swift
//  NIBM Article
//
//  Created by Kithmal Bulathsinhala on 10/31/19.
//  Copyright © 2019 NIBM. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase
import SwiftyJSON


class CreatNewPostViewController: UIViewController {
    var imagePicker: ImagePicker!
    var avatarImageUrl: String!
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtDescription: UITextField!
    @IBOutlet weak var imgView: UIImageView!
    
    @IBAction func showImagePicker(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func uploadArticle(_ sender: Any) {
        ///////////////////////////////////////////////////////////////////////////////////////////
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
        
        ///////////////////////////////////////////////////////////////////////////////////////////
        let loggedUserUID = UserDefaults.standard.string(forKey: "UserUID")
        
        let avatarRef = Database.database().reference().child("users").child(loggedUserUID!)
        avatarRef.observe(.value, with: { snapshot in
            
            let dict = snapshot.value as? [String: AnyObject]
            let json = JSON(dict as Any)
            
            self.avatarImageUrl = json["profileImageUrl"].stringValue

            
            
        })
        
        guard let title = txtTitle.text, !title.isEmpty else {
            alert.dismiss(animated: false, completion: nil)
            showAlert(message: "Title cannot be empty")
            return
        }
        
        guard let description = txtDescription.text, !description.isEmpty else {
            alert.dismiss(animated: false, completion: nil)
            showAlert(message: "Description cannot be empty")
            return
        }
        
        
        
        
        guard let image = imgView.image,
            let imgData = image.jpegData(compressionQuality: 1.0) else {
                alert.dismiss(animated: false, completion: nil)
                showAlert(message: "An Image must be selected")
                return
        }
        
        let imageName = UUID().uuidString
        
        let reference = Storage.storage().reference().child("articleImages").child(imageName)
        
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        
        reference.putData(imgData, metadata: metaData) { (meta, err) in
            if let err = err {
                alert.dismiss(animated: false, completion: nil)
                self.showAlert(message: "Error uploading image: \(err.localizedDescription)")
                return
            }
            
            reference.downloadURL { (url, err) in
                if let err = err {
                    alert.dismiss(animated: false, completion: nil)
                    self.showAlert(message: "Error fetching url: \(err.localizedDescription)")
                    return
                }
                
                guard let url = url else {
                    alert.dismiss(animated: false, completion: nil)
                    self.showAlert(message: "Error getting url")
                    return
                }
                
                let imgUrl = url.absoluteString
                
//                let dbChildName = UUID().uuidString
                
                
                let dbRef = Database.database().reference().child("articles").child("allArticles").childByAutoId()

                
                let data = [
                    "title" : title,
                    "description" : description,
                    "imageUrl" : imgUrl,
                    "userUID" : loggedUserUID,
                    "userAvatarImageUrl" : self.avatarImageUrl
                ]
                
                dbRef.setValue(data, withCompletionBlock: { ( err , dbRef) in
                    if let err = err {
                        self.showAlert(message: "Error uploading data: \(err.localizedDescription)")
                        return
                    }
                    alert.dismiss(animated: false, completion: nil)
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarController")
                    self.present(vc, animated: true, completion: nil)
                   
                    
                })
                
            }
            
        }
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

extension CreatNewPostViewController: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        self.imgView.image = image
    }
}

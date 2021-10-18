//
//  PostsTableViewCell.swift
//  InstagramClone
//
//  Created by Barış Can Akkaya on 14.10.2021.
//

import UIKit
import Firebase


class PostsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    var id: String!
    var like: Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    @IBAction func likeClicked(_ sender: UIButton) {
        let fsDatabase = Firestore.firestore()
        
        like += 1
        
        likesLabel.text = "\(like ?? 0) Likes"
        
        let likes = ["likes": (like) ?? 0] as [String: Any]
        
        fsDatabase.collection("Posts").document(id).setData(likes, merge: true)
        
    }
    
}


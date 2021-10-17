//
//  PostsViewController.swift
//  InstagramClone
//
//  Created by Barış Can Akkaya on 14.10.2021.
//

import UIKit
import Firebase

class PostsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewDelegate()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutClicked(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Do you want to logout?", message: "If you choose yes, you will logout!", preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        let cancelAction = UIAlertAction(title: "Yes", style: .default) { action in
            do {
                try Auth.auth().signOut()
                self.performSegue(withIdentifier: "goToRoot", sender: self)
            } catch let error {
                print(error.localizedDescription)
            }
        }
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
        
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

extension PostsViewController {
    
    func tableViewDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension PostsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        var cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostsTableViewCell
        setLayout(cell: &cell, height: height, width: width)
        cell.usernameLabel.text = "lazyiosdeveloper"
        cell.likesLabel.text = "0 Likes"
        cell.commentLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin a interdum dolor, id pharetra sapien. Etiam orci eros, sodales ac diam vitae, lobortis interdum metus. Sed tortor augue, ultrices sed elit quis, pellentesque feugiat arcu. "
        cell.userImageView.backgroundColor = .none
        cell.userImageView.image = UIImage(systemName: "photo")
        cell.locationLabel.text = "Istanbul, Turkey"
        cell.likeButton.setTitle("", for: .normal)
        
        return cell
    }
    
    func setLayout(cell: inout PostsTableViewCell, height: CGFloat, width: CGFloat) {
        cell.contentView.frame.size.width = width
        
        cell.usernameLabel.snp.makeConstraints { make in
            make.top.equalTo(height * 0.02)
            make.left.equalTo(width * 0.03)
            make.width.equalTo(width * 0.4)
        }
        cell.locationLabel.snp.makeConstraints { make in
            make.top.equalTo(height * 0.02)
            make.right.equalTo((width * -0.03))
            make.width.equalTo(width * 0.4)
        }
        cell.userImageView.snp.makeConstraints { make in
            make.width.equalTo(width)
            make.centerX.equalToSuperview()
            make.top.equalTo(cell.locationLabel.snp_bottomMargin).offset(height * 0.03)
            make.height.equalTo(height * 0.4)
        }
        cell.likesLabel.snp.makeConstraints { make in
            make.width.equalTo(width * 0.4)
            make.height.equalTo(height * 0.06)
            make.left.equalTo(width * 0.03)
            make.top.equalTo(cell.userImageView.snp_bottomMargin).offset(height * 0.02)
        }
        cell.likeButton.snp.makeConstraints { make in
            make.right.equalTo(width * -0.03)
            make.top.equalTo(cell.userImageView.snp_bottomMargin).offset(height * 0.02)
            make.width.equalTo(width * 0.15)
            make.height.equalTo(height * 0.06)
        }
        cell.commentLabel.snp.makeConstraints { make in
            make.width.equalTo(width * 0.94)
            make.centerX.equalToSuperview()
            make.top.equalTo(cell.likesLabel.snp_bottomMargin).offset(height * 0.02)
            make.bottom.equalTo(height * -0.03)
        }
        
        
    }
    
}

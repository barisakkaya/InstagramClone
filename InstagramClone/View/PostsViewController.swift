//
//  PostsViewController.swift
//  InstagramClone
//
//  Created by Barış Can Akkaya on 14.10.2021.
//

import UIKit
import Firebase
import Kingfisher

class PostsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var datas = [[String: Any]]()
    var docID = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewDelegate()
        getDatas()
        
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
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        var cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostsTableViewCell
        let data = datas[indexPath.row]
        setLayout(cell: &cell, height: height, width: width)
        
        cell.usernameLabel.text = data["byWho"] as? String
        cell.likesLabel.text = "\(data["likes"] as! Int) Likes"
        let like = data["likes"] as? Int
        if let like = like {
            cell.like = like
            print(cell.like)
        }
        cell.commentLabel.text = data["comment"] as? String
        cell.userImageView.backgroundColor = .none
        let url = URL(string: data["imageUrl"] as? String ?? "")
        KF.url(url)
            .placeholder(.none)
            .loadDiskFileSynchronously()
            .cacheMemoryOnly()
            .fade(duration: 0.25)
            .onProgress { receivedSize, totalSize in  }
            .onSuccess { result in  }
            .onFailure { error in }
            .set(to: cell.userImageView)
        
        cell.id = docID[indexPath.row]
        cell.locationLabel.text = data["locationName"] as? String
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
            make.top.equalTo(cell.usernameLabel.snp_bottomMargin).offset(height * 0.03)
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
    
    func getDatas() {
        let firestoreDb = Firestore.firestore()
        firestoreDb.collection("Posts").order(by: "time", descending: true).addSnapshotListener { snapshot, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                if let snapshot = snapshot {
                    self.datas.removeAll()
                    for doc in snapshot.documents {
                        self.datas.append(["byWho":doc.get("byWho")!,"comment":doc.get("comment")!,"imageUrl":doc.get("imageUrl")!,"likes":doc.get("likes")!,"time":doc.get("time")!,"locationName":doc.get("locationName")!])
                        self.docID.append(doc.documentID)
                        
                    }
                    self.tableView.reloadData()
                }
            }
        }
        
    }
    
}

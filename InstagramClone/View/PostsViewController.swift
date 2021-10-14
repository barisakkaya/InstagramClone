//
//  PostsViewController.swift
//  InstagramClone
//
//  Created by Barış Can Akkaya on 14.10.2021.
//

import UIKit
import Firebase

class PostsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

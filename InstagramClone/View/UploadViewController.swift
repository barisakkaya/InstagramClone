//
//  UploadViewController.swift
//  InstagramClone
//
//  Created by Barış Can Akkaya on 14.10.2021.
//

import UIKit
import SnapKit
import Firebase

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    var width: CGFloat!
    var height: CGFloat!
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        
    }
    
    @IBAction func uploadClicked(_ sender: UIButton) {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let imagesRef = storageRef.child("images")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5){
            let id = UUID().uuidString
            let image = imagesRef.child("\(id).jpg")
            
            image.putData(data, metadata: nil) { metaData, error in
                if let error = error {
                    self.showErrorAlert(error: "Something went wrong!", message: error.localizedDescription)
                } else {
                    image.downloadURL { url, error in
                        
                        if let error = error {
                            print(error.localizedDescription)
                        } else {
                            
                            if let imageUrl = url?.absoluteString {
                                
                                let db = Firestore.firestore()
                                
                                var ref: DocumentReference? = nil
                                
                                let fireStorePost = ["imageUrl" : imageUrl,
                                                     "byWho" : Auth.auth().currentUser!.email!,
                                                     "comment" : self.textField.text!,
                                                     "time" : DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .medium),
                                                     "likes" : 0
                                ] as [String : Any]
                                                                
                                ref = db.collection("Posts").addDocument(data: fireStorePost, completion: { err in
                                    if let err = err {
                                        self.showErrorAlert(error: "Error!", message: err.localizedDescription)
                                    } else {
                                        self.imageView.image = UIImage(systemName: "photo")
                                        self.textField.text = ""
                                        self.view.endEditing(true)
                                        self.imageView.backgroundColor = .systemGray4
                                        self.tabBarController?.selectedIndex = 0
                                        
                                    }
                                })
                                
                                
                            }
                        }
                    }
                }
                
            }
            
        }
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
    
}

extension UploadViewController {
    func setLayout() {
        //ImageView işlemleri
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(gestureRecognizer)
        
        height = UIScreen.main.bounds.height
        width = UIScreen.main.bounds.width
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(height * 0.15)
            make.width.equalTo(width * 0.75)
            make.height.equalTo(height * 0.33)
        }
        textField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.imageView.snp_bottomMargin).offset(height * 0.07)
            make.width.equalTo(width * 0.75)
            make.height.equalTo(height * 0.07)
        }
        uploadButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.textField.snp_bottomMargin).offset(height * 0.20)
            make.width.equalTo(width * 0.75)
            make.height.equalTo(height * 0.07)
        }
        
    }
    
    @objc func selectImage() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        pickerController.allowsEditing = true
        present(pickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        imageView.backgroundColor = .none
        self.dismiss(animated: true, completion: nil)
    }
    
    func showErrorAlert(error: String, message: String) {
        let alert = UIAlertController(title: error, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK!", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}

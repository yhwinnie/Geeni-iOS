//
//  ProfileTableViewController.swift
//  Geeni-iOS
//
//  Created by Sahil Dhawan on 01/10/17.
//  Copyright © 2017 wiwen. All rights reserved.
//

import UIKit

class ProfileTableViewController: UITableViewController {
    
    var post: Post?
    
    @IBOutlet weak var majorLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var ratingCollectionView: UICollectionView!
    @IBOutlet weak var ratingFlowLayout: UICollectionViewFlowLayout!
    
    var userRating : Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userImageView.makeRound()
        userImageView.setBorder(color : UIColor.white.cgColor , width : 2)
        tableView.allowsSelection = false
        getProfileDetails()
        setupRatingCollectionView(userRating)
        tableView.tableFooterView = UIView()
    }
    
    func getProfileDetails(){
        FirebaseCalls().getUserDetails { (userDetails , bool) in
            if bool {
                let user = userDetails!
                self.majorLabel.text = user.major
                self.userNameLabel.text = user.username
                 let imageURL = URL(string: user.photo_gs!)
                 if user.photo_gs?.first == "g"{
                    storageRef = storage.reference(forURL: user.photo_gs!)
                    storageRef.downloadURL { (url, error) in
                        self.userImageView.kf.setImage(with: url)
                        self.backgroundImageView.kf.setImage(with: url)
                    }
                 } else {
                    self.userImageView.kf.setImage(with: imageURL)
                    self.backgroundImageView.kf.setImage(with: imageURL)
                }
                if user.tutor_bool! {
                    self.userRating = user.overall_ratings_tutor!
                } else {
                    self.userRating = user.overall_ratings_student!
                }
            }
            else {
                let alertController = UIAlertController(title: "Geeni", message: "Unexpected error occurred!", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    self.dismiss(animated: true, completion: nil)
                })
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    func setupRatingCollectionView(_ rating : Double) {
        ratingCollectionView.dataSource = self
        ratingCollectionView.allowsSelection = false
        let ratingSize : CGFloat = 15.0
        let spacing : CGFloat = 2.0
        ratingFlowLayout.minimumLineSpacing = spacing
        ratingFlowLayout.minimumInteritemSpacing = spacing
        ratingFlowLayout.itemSize = CGSize(width: ratingSize, height: ratingSize)
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0 :
            return 90.0
        case 1:
            return 65.0
        case 2:
            return 44.0
        default:
            return 44.0
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "", size: 18)
        header.textLabel?.textColor = colors.tableHeaderColor
    }
}

extension ProfileTableViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ratingCell", for: indexPath)
        return cell
    }
}



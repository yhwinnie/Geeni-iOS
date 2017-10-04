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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userImageView.makeRound()
        userImageView.setBorder(color : UIColor.white.cgColor , width : 2)
        tableView.allowsSelection = false
        setupRatingCollectionView()
        tableView.tableFooterView = UIView()
    }
    
    func setupRatingCollectionView() {
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



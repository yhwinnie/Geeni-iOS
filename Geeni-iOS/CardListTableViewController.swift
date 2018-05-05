//
//  CardListTableViewController.swift
//  Geeni-iOS
//
//  Created by Winnie Wen on 4/2/17.
//  Copyright © 2017 wiwen. All rights reserved.
//

import UIKit
import Firebase
import SWRevealViewController

class CardListTableViewController: UITableViewController {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    var cards = [Card]()
    
    var newPostBool : Bool? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        revealSideMenu(menuButton)
        tableView.tableFooterView = UIView()
        setupNavigationBar(title: "Cards")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCards()
    }
    
    func getCards() {
        guard let uid = uid else { return }
        //        ref.child("cards").queryOrdered(byChild: "user_id").queryEqual(toValue: uid).observe(.value, with: { (snapshot) in
        //
        //            if let dictionary = snapshot.value as? [String: AnyObject] {
        //                let card = Card(dictionary: dictionary)
        //                self.cards.append(card)
        //
        //                DispatchQueue.main.async(execute: {
        //                    self.tableView.reloadData()
        //                })
        //            }
        //
        //
        //        }, withCancel: nil)
        
        ref.child("cards").observe(.value, with: { (snapshot) in
            self.cards = []
            let cardArray = snapshot.children.allObjects as NSArray
            for card in cardArray {
                let cardSnapshot = card as! DataSnapshot
                let cardValue = cardSnapshot.value as! NSDictionary
                let userId = cardValue["user_id"] as! String
                if userId == uid {
                    let cardObject = Card(dictionary : cardValue as! [String : Any])
                    self.cards.append(cardObject)
                }
            }
            if self.cards.count > 0 {
                self.tableView.reloadData()
            }
        })
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards.count
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if newPostBool != nil {
            if newPostBool! {
                UserDetails.selectedCard = cards[indexPath.item]
                self.navigationController?.popViewController(animated: true)
            } else {
                
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CardListTableViewCell
        cell.card = self.cards[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "addCardSegue", sender: self)
    }
    
}






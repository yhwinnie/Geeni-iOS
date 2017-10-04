//
//  CardListTableViewController.swift
//  Geeni-iOS
//
//  Created by Winnie Wen on 4/2/17.
//  Copyright © 2017 wiwen. All rights reserved.
//

import UIKit
import SWRevealViewController

class CardListTableViewController: UITableViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var cards = [Card]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        revealSideMenu(menuButton)
        getCards()
        setupNavigationBar(title: "Cards")
    }
    
    func getCards() {
        guard let uid = uid else { return }
        ref.child("cards").queryOrdered(byChild: "user_id").queryEqual(toValue: uid).observe(.value, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let card = Card(dictionary: dictionary)
                self.cards.append(card)
                
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                })
            }
            
            
        }, withCancel: nil)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.cards.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CardListTableViewCell

        cell.card = self.cards[indexPath.row]

        return cell
    }

}

// Card Model 
class Card: NSObject {
    var _id: String?
    var card_token: String?
    var last_four: String?
    var provider: String?
    var type: String?
    var user_id: String?

    
    
    init(dictionary: [String: Any]) {
        self._id = dictionary["_id"] as? String ?? ""
        self.card_token = dictionary["card_token"] as? String ?? ""
        self.last_four = dictionary["last_four"] as? String ?? ""
        self.provider = dictionary["provider"] as? String ?? ""
        
        self.type = dictionary["type"] as? String ?? ""

        self.user_id = dictionary["user_id"] as? String ?? ""
        
    }
}



class CardListTableViewCell: UITableViewCell {
    @IBOutlet weak var cardNumber: UILabel!
    @IBOutlet weak var cardImageView: UIImageView!
    
    
    var card: Card? {
        
        didSet {
            guard let card = card else { return }
            
            cardNumber.text = card.last_four

            // Set Images
            
            guard let provider = card.provider else { return }
            cardImageView.image = UIImage(named: provider)

        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}




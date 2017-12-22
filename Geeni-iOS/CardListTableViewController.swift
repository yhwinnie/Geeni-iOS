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
        tableView.tableFooterView = UIView()
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
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CardListTableViewCell
//        cell.card = self.cards[indexPath.row]
        return cell
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "addCardSegue", sender: self)
    }
    
}






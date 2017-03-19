//
//  StudentPostViewController.swift
//  Geeni-iOS
//
//  Created by Casey Takeda on 3/16/17.
//  Copyright © 2017 wiwen. All rights reserved.
//

import UIKit

class NewsFeedViewController: UITableViewController {
    
    var courses = ["CS 61A", "CS 61B", "CS 70"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.title = "News Feed"
        navigationController?.navigationBar.barTintColor = UIColor(red: CGFloat(0.20), green: CGFloat(0.60), blue: CGFloat(1.0), alpha: CGFloat(1.0))
        
        tableView.register(StudentCell.self, forCellReuseIdentifier: "studentID")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Insert", style: .plain, target: self, action: #selector(NewsFeedViewController.insert))
        
        self.view.layoutIfNeeded()
        
    }
    
    func insert() {
        courses.append("Student \(courses.count + 1)")
        
        let insertionIndexPath = NSIndexPath(row: courses.count - 1, section: 0)
        tableView.insertRows(at: [insertionIndexPath as IndexPath], with: .automatic)
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let studentCell = tableView.dequeueReusableCell(withIdentifier: "studentID", for: indexPath) as! StudentCell
        studentCell.courseName.text = courses[indexPath.row]
        studentCell.myTableViewController = self
        return studentCell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(100)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerID")
    }
    
    func deleteCell(cell: UITableViewCell) {
        if let deletionIndexPath = tableView.indexPath(for: cell) {
            courses.remove(at: deletionIndexPath.row)
            tableView.deleteRows(at: [deletionIndexPath], with: .automatic)
        }
        
    }
    
}


class StudentCell: UITableViewCell {
    
    var myTableViewController: NewsFeedViewController?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let studentProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "puppy")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let courseName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Delete", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func setupViews() {
        addSubview(studentProfileImageView)
        addSubview(courseName)
        
//        addSubview(actionButton)
        
//        actionButton.addTarget(self, action: #selector(StudentCell.handleAction), for: .touchUpInside)
        
        // Make the User Profile Picture Circular
        studentProfileImageView.layer.borderWidth = 1.0
        studentProfileImageView.layer.masksToBounds = false
        studentProfileImageView.layer.cornerRadius = 42.5
        studentProfileImageView.layer.borderColor = UIColor.white.cgColor
        studentProfileImageView.clipsToBounds = true
        
        // Horizontal
        addConstrainsWithFormat(format: "H:|-16-[v0(85)]-16-|", views: studentProfileImageView)
        
        // Vertical Constraints
        addConstrainsWithFormat(format: "V:|-16-[v0(75)]-16-|", views: studentProfileImageView)
//        addConstrainsWithFormat(format: "V:|[v0]|", views: studentName)
        
        // Top Constraints
    }
    
    func handleAction() {
        myTableViewController?.deleteCell(cell: self)
    }
    
}

extension UIView {
    func addConstrainsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

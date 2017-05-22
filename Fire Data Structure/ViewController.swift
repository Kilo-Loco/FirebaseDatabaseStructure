//
//  ViewController.swift
//  Fire Data Structure
//
//  Created by Kyle Lee on 5/21/17.
//  Copyright © 2017 Kyle Lee. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    
    var posts = [Post]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DatabaseService.shared.postsReference.observe(FIRDataEventType.value, with: { (snapshot) in
            print(snapshot)
            guard let postsSnapshot = PostsSnapshot(with: snapshot) else { return }
            self.posts = postsSnapshot.posts
            self.posts.sort(by: { $0.date.compare($1.date) == .orderedDescending })
            self.tableView.reloadData()
            
        })
        
    }
    
    
    @IBAction func onAddTapped(_ sender: Any) {
        
        let alert = UIAlertController(title: "Post Something", message: "What would you like to post?", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Enter message here"
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let post = UIAlertAction(title: "Post", style: .default) { _ in
            guard let text = alert.textFields?.first?.text else { return }
            print(text)
            
            let dateString = String(describing: Date())
            
            let parameters = ["username"    : "@kilo_loco",
                              "message"     : text,
                              "date"        : dateString]
            
            DatabaseService.shared.postsReference.childByAutoId().setValue(parameters)
        }
        alert.addAction(cancel)
        alert.addAction(post)
        present(alert, animated: true, completion: nil)
        
    }


}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = posts[indexPath.row].message
        cell.detailTextLabel?.text = posts[indexPath.row].username
        return cell
    }
    
}











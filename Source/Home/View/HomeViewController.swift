//
//  HomeViewController.swift
//  Conn
//
//  Created by Andrew Castro on 28/10/18.
//  Copyright © 2018 Andrew Castro. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {

    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var viewBody: UIView!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var createPost: UIButton!

    
    let service = FirebaseService()
    let CellNameID = "PostTableViewCell"
    
    var userNamePost = ""
    var posts = [Post]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.tableview.register(UINib(nibName: CellNameID, bundle: nil), forCellReuseIdentifier: "PostCell")
        self.observerPost()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableview.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let post = segue.destination as? PostViewController{
            if segue.identifier == "postViewController" {
                post.userNamePost = self.userNamePost
            }
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 134.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostTableViewCell
        cell.setValues(post: posts[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let controller = UIStoryboard.init(name: "DescriptionPost", bundle: nil).instantiateViewController(withIdentifier: "descriptionPost") as? DescriptionPostViewController {
        controller.detailsPost = posts[indexPath.row]
        self.present(controller, animated: true, completion: nil)
        }
    }
}


extension HomeViewController {
    
    func observerPost(){
        let postReference = Database.database().reference().child("posts")
        postReference.observe(.value, with: { snapshot in
            var tempPosts = [Post]()
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot,
                    let dict = childSnapshot.value as? [String:Any],
                    let username = dict["username"] as? String,
                    let theme = dict["theme"] as? String,
                    let _ = dict["timestamp"] as? Double,
                    let optionalField = dict["optionalField"] as? String,
                    let secondOptionalField = dict["secondOptionalField"] as? String,
                    let thirdOptionalField = dict["thirdOptionalField"] as? String,
                    let title = dict["title"] as? String {
                    
                    let _ = UserProfile(userId: "", username: username)
                    let post = Post(title: title, theme: theme, optionalField: optionalField, secondOptionalField: secondOptionalField, thirdOptionalField: thirdOptionalField)
                    tempPosts.append(post)
                }
            }
            self.posts = tempPosts
            self.tableview.reloadData()
        })
    }
}

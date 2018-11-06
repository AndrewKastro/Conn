//
//  DescriptionPostViewController.swift
//  Conn
//
//  Created by Andrew Castro on 30/10/18.
//  Copyright © 2018 Andrew Castro. All rights reserved.
//

import UIKit
import Firebase

class DescriptionPostViewController: UIViewController {
    
    @IBOutlet weak var titleDescription: UILabel!
    @IBOutlet weak var advisor: UILabel!
    @IBOutlet weak var student: UILabel!
    @IBOutlet weak var technology: UILabel!
    @IBOutlet weak var theme: UILabel!
    @IBOutlet weak var tableview: UITableView!
    
    let comment = CommentsViewController()
    let CellNameID = "CommentsTableViewCell"
    
    var showToast = false
    var detailsPost:Post?
    var comments = [Comment]()
    
    @IBAction func actionComment(_ sender: Any) {
        if let controller = UIStoryboard.init(name: "Comments", bundle: nil).instantiateViewController(withIdentifier: "comments") as? CommentsViewController {
            controller.attach(view: self)
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    @IBAction func backHome(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview.register(UINib(nibName: CellNameID, bundle: nil), forCellReuseIdentifier: "Comment")
        self.observerComment()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setValues()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if self.showToast {
            self.toastMessage("Comentário criado com sucesso!!!")
        }
    }
    
    func setValues(){
        self.titleDescription.text = detailsPost?.title
        self.advisor.text = detailsPost?.optionalField
        self.student.text = detailsPost?.secondOptionalField
        self.technology.text = detailsPost?.thirdOptionalField
        self.theme.text = detailsPost?.theme
    }
}

extension DescriptionPostViewController: CommentsViewControllerDelegate {
    
    func showMessage() {
        self.showToast = true
    }
}

extension DescriptionPostViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 79
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "Comment", for: indexPath) as! CommentsTableViewCell
        cell.setValues(comment: comments[indexPath.row])
        return cell
    }
}

extension DescriptionPostViewController {

    func observerComment(){
        let postReference = Database.database().reference().child("posts/comments")
        postReference.observe(.value, with: { snapshot in
            var tempPosts = [Comment]()
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot,
                    let dict = childSnapshot.value as? [String:Any],
                    let _ = dict["timestamp"] as? Double,
                    let wrote = dict["wrote"] as? String {

                    let comm = Comment(post: wrote, comment: wrote)
                    tempPosts.append(comm)
                }
            }
            self.comments = tempPosts
            self.tableview.reloadData()
        })
    }
}

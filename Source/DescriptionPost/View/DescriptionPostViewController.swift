//
//  DescriptionPostViewController.swift
//  Conn
//
//  Created by Andrew Castro on 30/10/18.
//  Copyright © 2018 Andrew Castro. All rights reserved.
//

import UIKit

class DescriptionPostViewController: UIViewController {
    @IBOutlet weak var titleDescription: UILabel!
    @IBOutlet weak var advisor: UILabel!
    @IBOutlet weak var student: UILabel!
    @IBOutlet weak var technology: UILabel!
    @IBOutlet weak var theme: UILabel!
    
    @IBAction func backHome(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addComment(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

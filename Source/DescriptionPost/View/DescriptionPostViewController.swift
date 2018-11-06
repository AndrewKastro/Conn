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
    
    var detailsPost:Post?
    
    @IBAction func backHome(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setValues()
    }
    
    func setValues(){
        self.titleDescription.text = detailsPost?.title
        self.advisor.text = detailsPost?.optionalField
        self.student.text = detailsPost?.secondOptionalField
        self.technology.text = detailsPost?.thirdOptionalField
        self.theme.text = detailsPost?.theme
    }
}

//
//  TableViewCell.swift
//  Conn
//
//  Created by Andrew Castro on 30/10/18.
//  Copyright © 2018 Andrew Castro. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var titlePost: UILabel!
    @IBOutlet weak var optionalField: UILabel!
    @IBOutlet weak var thirdOptionalField: UILabel!
    @IBOutlet weak var seconOptionalField: UILabel!
    @IBOutlet weak var theme: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setValues(post:Post) {
        self.titlePost.text = post.title
        self.theme.text = post.theme
        self.optionalField.text = post.optionalField
        self.seconOptionalField.text = post.secondOptionalField
        self.thirdOptionalField.text = post.thirdOptionalField
    }
    
}

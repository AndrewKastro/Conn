//
//  CommentsTableViewCell.swift
//  Conn
//
//  Created by Andrew Castro on 06/11/18.
//  Copyright © 2018 Andrew Castro. All rights reserved.
//

import UIKit

class CommentsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var comment: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setValues(comment:Comment){
        self.comment.text = comment.comment
    }
}

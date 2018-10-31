//
//  Post.swift
//  Conn
//
//  Created by Andrew Castro on 28/10/18.
//  Copyright © 2018 Andrew Castro. All rights reserved.
//

import Foundation

class Post {
    
    var title:String?
    var theme:String?
    var optionalField:String?
    var secondOptionalField:String?
    var thirdOptionalField:String?
    
    init(title:String, theme:String, optionalField:String, secondOptionalField:String, thirdOptionalField:String) {
        self.title = title
        self.theme = theme
        self.optionalField = optionalField
        self.secondOptionalField = secondOptionalField
        self.thirdOptionalField = thirdOptionalField
    }
}

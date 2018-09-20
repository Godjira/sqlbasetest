//
//  Preps.swift
//  sqltest
//
//  Created by Godjira on 9/18/18.
//  Copyright © 2018 Godjira. All rights reserved.
//

import Foundation

class Prep {
    
    var id: Int?
    var name: String?
    var about: NSAttributedString?
    var picture: String?
    
    init(id: Int, name: String, about: NSAttributedString, picture: String) {
        
        self.id = id
        self.name = name
        self.about = about
        self.picture = picture
        
    }
    
}

class PrepInfo {
    
    var id: Int?
    var prepId: Int?
    var name: String?
    var text: String?
    var orderInfo: Int?
    
    init(id: Int,prepId: Int?, name: String, text: String, orderInfo: Int) {
        
        self.id = id
        self.prepId = prepId
        self.name = name
        self.text = text
        self.orderInfo = orderInfo
        
    }
    
}

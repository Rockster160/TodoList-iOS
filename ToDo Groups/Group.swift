//
//  Group.swift
//  ToDo Groups
//
//  Created by Chad Zeluff on 11/12/15.
//  Copyright © 2015 Rocco Nicholls. All rights reserved.
//

import UIKit

class Group: NSObject {
    var name: String
    var tasks: [Task] = []
    
    init(name: String) {
        self.name = name
        super.init()
    }
    
    
}

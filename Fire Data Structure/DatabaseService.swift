//
//  DatabaseService.swift
//  Fire Data Structure
//
//  Created by Kyle Lee on 5/21/17.
//  Copyright © 2017 Kyle Lee. All rights reserved.
//

import Foundation
import Firebase

class DatabaseService {
    
    static let shared = DatabaseService()
    private init() {}
    
    let postsReference = FIRDatabase.database().reference().child("posts")
    let beersReference = FIRDatabase.database().reference().child("beers")
    
}

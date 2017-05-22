//
//  PostsSnapshot.swift
//  Fire Data Structure
//
//  Created by Kyle Lee on 5/21/17.
//  Copyright © 2017 Kyle Lee. All rights reserved.
//

import Foundation
import Firebase

struct PostsSnapshot {
    
    let posts: [Post]
    
    init?(with snapshot: FIRDataSnapshot) {
        var posts = [Post]()
        guard let snapDict = snapshot.value as? [String: [String: Any]] else { return nil }
        for snap in snapDict {
            guard let post = Post(postId: snap.key, dict: snap.value) else { continue }
            posts.append(post)
        }
        self.posts = posts
    }
}

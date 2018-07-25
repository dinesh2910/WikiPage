//
//  StatsModel.swift
//  Assignment
//
//  Created by dinesh danda on 07/24/18.
//  Copyright © 2018 dinesh danda. All rights reserved.
//

import Foundation
class Stats {
    
    var articles = 0
    var videos = 0
    var discussions = 0
    

    init(stats : [String: Any]) {
        
        if let articles =  stats["articles"] as? Int{
            self.articles = articles
        }
        if let videos =  stats["videos"] as? Int{
            self.videos = videos
        }
        if let discussions =  stats["discussions"] as? Int{
            self.discussions = discussions
        }
    }
}

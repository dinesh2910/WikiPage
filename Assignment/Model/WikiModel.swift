//
//  WikiModel.swift
//  Assignment
//
//  Created by dinesh danda on 07/24/18.
//  Copyright © 2018 dinesh danda. All rights reserved.
//

import Foundation
class WikiModel {
    var stats : Stats!
    var title = ""
    var desc = ""
    var imgUrl = ""
    var id = 0
    init(json : [String: Any]) {
        
        if let id =  json["id"] as? Int{
            self.id = id
        }
        if let title =  json["title"] as? String{
            self.title = title
        }
        if let desc =  json["desc"] as? String{
            self.desc = desc
        }
        if let imgUrl =  json["image"] as? String{
            self.imgUrl = imgUrl
        }
        if let stats =  json["stats"] as? [String : Any]{
            self.stats = Stats(stats: stats)
        }
    }
}

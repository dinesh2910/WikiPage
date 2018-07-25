//
//  CustomTableCell.swift
//  Assignment
//
//  Created by dinesh danda on 07/24/18.
//  Copyright © 2018 dinesh danda. All rights reserved.
//

import UIKit
import SDWebImage

class CustomTableCell: UITableViewCell {

    @IBOutlet var imgVw: UIImageView!
    @IBOutlet var titleLbl: UILabel!
    
    @IBOutlet var videosBtn: UIButton!
    @IBOutlet var articlesBtn: UIButton!
    @IBOutlet var discussionsBtn: UIButton!
    @IBOutlet var descLbl: UILabel!
    class var identifier: String {
        return "\(self)"
    }
    
    class var nibName: String {
        return "\(self)"
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(wiki : WikiModel)  {
        
        self.titleLbl.text = wiki.title
        self.descLbl.text = wiki.desc
        loadImageWithUrlString(urlString: wiki.imgUrl)
        setStats(stats: wiki.stats)
    }
   fileprivate func loadImageWithUrlString(urlString : String)  {
    self.imgVw.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "index"))

    }
    fileprivate func setStats(stats : Stats){
            self.articlesBtn.setTitle(convertIntoKs(count: stats.articles), for: .normal)
        
            self.videosBtn.setTitle(convertIntoKs(count: stats.videos), for: .normal)
            self.discussionsBtn.setTitle(convertIntoKs(count: stats.discussions), for: .normal)
    }
    
    fileprivate func convertIntoKs (count : Int) -> String{
        
        let ks = count/1000
        if ks < 1 {
            //let x = count%1000
            return "\(count)"
        }
        return "\(ks)k"
    }
    
}

//
//  DetailsTableCell.swift
//  Assignment
//
//  Created by dinesh danda on 07/24/18.
//  Copyright © 2018 dinesh danda. All rights reserved.
//

import UIKit

class DetailsTableCell: UITableViewCell {
    class var identifier: String {
        return "\(self)"
    }
    
    class var nibName: String {
        return "\(self)"
    }
    @IBOutlet var descLbl: UILabel!
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(model : WikiModel) {
        self.descLbl.text = model.desc
        self.titleLbl.text = model.title
        loadImageWithUrlString(urlString: model.imgUrl)

    }
    fileprivate func loadImageWithUrlString(urlString : String)  {
        self.imgView.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "index"))
    }
}

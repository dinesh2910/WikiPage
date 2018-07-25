//
//  DetailsViewController.swift
//  Assignment
//
//  Created by dinesh danda on 07/24/18.
//  Copyright © 2018 dinesh danda. All rights reserved.
//

import UIKit
import SKActivityIndicatorView

class DetailsViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    var wikiID = 0
    var dataModel : WikiModel!
    var tableArr = [WikiModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableViewNibs()
        getDetails()
    }
    func getDetails()  {
//        http://www.wikia.com/api/v1/Wikis/Details?ids=643102
        SingletonCalss.getApiCall(urlString: "Details?ids=\(wikiID)") { (success, response) in
            if success {
                if let data = response {
                    
                    if let wiki = data["items"] as? [String: Any]
                    {
                        if let model = wiki["\(self.wikiID)"] as? [String: Any]{
                        
                        self.dataModel = WikiModel(json: model)
                        DispatchQueue.main.async {
                            self.tableView.delegate = self
                            self.tableView.dataSource = self
                            self.tableView.reloadData()
                            SKActivityIndicator.dismiss()
                            }
                        }
                    }
                }
            }
            else{
                SingletonCalss.showAlertViewWith(vc: self, title: "Oops", message: "Something went wrong. Please try again later")

            }
        }
    }
    fileprivate func registerTableViewNibs()
    {
        tableView.register(UINib(nibName: DetailsTableCell.nibName, bundle: nil), forCellReuseIdentifier: DetailsTableCell.identifier)
    }
}
extension DetailsViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell =  tableView.dequeueReusableCell(withIdentifier: DetailsTableCell.identifier) as! DetailsTableCell
        cell.setupCell(model: self.dataModel)
        return cell
    }
}

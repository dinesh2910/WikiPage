//
//  ViewController.swift
//  Assignment
//
//  Created by dinesh danda on 07/24/18.
//  Copyright © 2018 dinesh danda. All rights reserved.
//

import UIKit
import SKActivityIndicatorView

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    var tableArr = [WikiModel]()
    var currentBatch = 1
    var totalBatches = 0
    var previousBatch = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableViewNibs()
        getResponce()
        // Do any additional setup after loading the view, typically from a nib.
    }
    func getResponce()  {
        SingletonCalss.getApiCall(urlString: "List?expand=1&limit=25&batch=\(currentBatch)") { (success, responce) in
            if success {
                if let data = responce{
                    
                    if let dataArr = data["items"] as? [[String:Any]]
                    {
                        for wiki in dataArr{
                            self.tableArr.append(WikiModel(json: wiki))
                        }
                        
                        if let cBatch = data["currentBatch"] as? Int{
                            self.currentBatch = cBatch
                            self.previousBatch = cBatch
                        }
                        if let batches = data["batches"] as? Int {
                            self.totalBatches = batches
                        }
                    }
                    DispatchQueue.main.async {
                        self.tableView.delegate = self
                        self.tableView.dataSource = self
                        SKActivityIndicator.dismiss()
                        self.tableView.reloadData()
                    }
                }
                else{
                    SingletonCalss.showAlertViewWith(vc: self, title: "Oops", message: "Something went wrong. Please try again later")
                }
            }
            else{
                SingletonCalss.showAlertViewWith(vc: self, title: "Oops", message: "Something went wrong. Please try again later")
            }
           
        }
    }
    fileprivate func registerTableViewNibs() {
        
        tableView.register(UINib(nibName: CustomTableCell.nibName, bundle: nil), forCellReuseIdentifier: CustomTableCell.identifier)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension ViewController : UITableViewDataSource {
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
     {
        return tableArr.count
     }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
     {
        let cell =  tableView.dequeueReusableCell(withIdentifier: CustomTableCell.identifier) as! CustomTableCell
        cell.setupCell(wiki: tableArr[indexPath.row])
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let  height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height {
            
            if currentBatch <= totalBatches && currentBatch == previousBatch{
                currentBatch = currentBatch + 1
                getResponce()
            }
        }
    }
}
extension ViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        vc.wikiID = tableArr[indexPath.row].id
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


//
//  SingletonClass.swift
//  Assignment
//
//  Created by dinesh danda on 07/24/18.
//  Copyright © 2018 dinesh danda. All rights reserved.
//

import Foundation
import SKActivityIndicatorView
class SingletonCalss {
    static let sharedManager = SingletonCalss()
    static let BASE_URL = "http://www.wikia.com/api/v1/Wikis/"
    class func getApiCall(urlString : String , completionHandler : @escaping(_ success : Bool ,_ responce : [String : Any]?)-> Void){
        SKActivityIndicator.show("", userInteractionStatus: false)

        let mainUrl = BASE_URL + urlString
        let url = URL(string: mainUrl)!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let err = error
            {
                print(err.localizedDescription)
                completionHandler(false,nil)
            }
            else{
            guard let unwrappedData = data else { return }
            do {
                let jsonData = try JSONSerialization.jsonObject(with: unwrappedData, options: .allowFragments) as![String:Any]
                print(jsonData)
                completionHandler(true , jsonData)
            }
            catch {
                print("json error: \(error)")
                completionHandler(false , nil)
            }
        }
        }
        task.resume()
    }
    
    class func showAlertViewWith(vc: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (act) in
            
        }
        alert.addAction(action)
        vc.present(alert, animated: true, completion: nil)
    }
}

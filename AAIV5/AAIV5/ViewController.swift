//
//  ViewController.swift
//  AAIV5
//
//  Created by Louie Jay Arreza on 10/12/20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scanBtn()
        
    }

    func scanBtn() {
        let scanButton = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        scanButton.backgroundColor = .orange
        scanButton.center = self.view.center
        scanButton.setTitle("scan button", for: .normal)
        scanButton.addTarget(self, action: #selector(scanAction), for: .touchUpInside)
        self.view.addSubview(scanButton)
    }
    
    @objc func scanAction(sender: UIButton!) {

        let rootVC = AAILivenessViewController()
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true, completion: nil)
  
    }
    
    func fetchApi() {
        
        let url = URL(string: "https://ph-api.advance.ai/ph/openapi/face-identity/v1/liveness-detection")
        guard url != nil else {
            print("Error url object")
            return
        }
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        
        let headers = ["X-ADVAI-KEY": "6178325cd857527c",
                       "Content-Type": "application/json",
                       "livenessId": "ddsd-9e6-dcc9-4ca1-bdfe-9f001c05f1b1",
                       "resultType": "IMAGE_URL"]
        
        request.allHTTPHeaderFields = headers
        
        let jsonObject = ["message": "Liveness id does not exist",
                          "data": nil,
                          "extra": nil,
                          "code": "LIVENESS_ID_NOT_EXISTED",
                          "transactionId": "196eb0c777789e58",
                          "pricingStrategy": "FREE"]
    
        do {
            let requestBody = try JSONSerialization.data(withJSONObject: jsonObject, options: .fragmentsAllowed)
            request.httpBody = requestBody
        } catch {
            print("Error creating the data object from json")
        }
        
        let session = URLSession.shared
        let datatask = session.dataTask(with: request) { (data, response, error) in
            
            if error == nil && data != nil {
                
                do {
                    let dictionary = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                    print(dictionary)
                    
                } catch {
                    print("Error parsing response data")
                }
            }
        }
        datatask.resume()
    }
}

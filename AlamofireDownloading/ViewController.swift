//
//  ViewController.swift
//  AlamofireDownloading
//
//  Created by Arip Khozhbanov on 11.11.2022.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var completedLabel: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var progressView: UIProgressView!
    
    let imageURL = "https://images.theconversation.com/files/378097/original/file-20210111-23-bqsfwl.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=1200&h=1200.0&fit=crop"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        indicator.startAnimating()
        getImage(url: imageURL)
    }

    func getImage(url: String) {
        
        AF.download(url)
            
            .validate()
            
            .downloadProgress { progress in
                self.completedLabel.text = progress.localizedDescription
                self.progressView.setProgress(Float(progress.fractionCompleted), animated: true)
            }
            
            .responseData { response in
            if let data = response.value {
                let imagaData = UIImage(data: data)
                self.imageView.image = imagaData
                self.indicator.stopAnimating()
                self.indicator.isHidden = true
                
                self.progressView.isHidden = true
            }
            else {
                    print("Ошибка")
            }
        }
    }

}


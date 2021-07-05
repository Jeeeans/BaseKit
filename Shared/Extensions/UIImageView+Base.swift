//
//  UIImageView+Base.swift
//  BaseKit
//
//  Created by Sungjun Chin on 2021/06/22.
//

import UIKit
import Alamofire
import RxSwift

extension UIImageView {
    func loadFromURL(_ urlString: String?, placeholder: String? = nil, completion: ((UIImage?, Error?) -> Void)? = nil) {
        guard let urlString = urlString, let url = URL(string: urlString) else { return }
        self.loadFromURL(url, placeholder: placeholder, completion: completion)
    }
    
    func loadFromURL(_ urlString: String?, placeholder: UIImage? = nil, completion: ((UIImage?, Error?) -> Void)? = nil) {
        guard let urlString = urlString, let url = URL(string: urlString) else { return }
        self.loadFromURL(url, placeholder: placeholder, completion: completion)
    }
    
    func loadFromURL(_ url: URL?, placeholder: String? = nil, completion: ((UIImage?, Error?) -> Void)? = nil) {
        let image = UIImage(named: placeholder ?? "")
        self.loadFromURL(url, placeholder: image, completion: completion)
    }
    
    func loadFromURL(_ url: URL?, placeholder: UIImage? = nil, completion: ((UIImage?, Error?) -> Void)? = nil) {
        guard let url = url else { return }
        
        self.image = placeholder
        
        AF.request(url)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    let image = UIImage(data: data)
                    if let completion = completion {
                        completion(image, nil)
                    } else {
                        self.image = image
                    }
                    break
                case .failure(let error):
                    if let completion = completion {
                        completion(nil, error)
                    }
                    break
                }
            }
        
    }
}

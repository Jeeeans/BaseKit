//
//  UIImage+Base.swift
//  BaseKit
//
//  Created by Sungjun Chin on 2021/07/01.
//

import UIKit
import Alamofire
import RxSwift

/**
 * static functions
 */
public extension UIImage {
    static func getFromUrl(_ urlString: String?) -> Observable<UIImage>? {
        guard let urlString = urlString, let url = URL(string: urlString) else { return nil }
        return UIImage.getFromUrl(url)
    }
    
    static func getFromUrl(_ url: URL?) -> Observable<UIImage>? {
        guard let url = url else { return nil }
        
        
        return Observable<UIImage>.create { observer in
            AF.request(url)
                .responseData { response in
                    UIImage.onCompleted(observer: observer, response: response)
                }
            
            return Disposables.create {
                
            }
        }
    }
    
    private static func onCompleted(observer: AnyObserver<UIImage>, response: AFDataResponse<Data>) {
        switch response.result {
        case .success(let data):
            let image = UIImage(data: data)
            UIImage.success(observer: observer, image: image)
            break
        case .failure(let error):
            UIImage.failure(observer: observer, error: error)
            break
        }
    }
    
    private static func success(observer: AnyObserver<UIImage>, image: UIImage?) {
        guard let image = image else { return }
        observer.onNext(image)
    }
    
    private static func failure(observer: AnyObserver<UIImage>, error: Error) {
        observer.onError(error)
    }
}

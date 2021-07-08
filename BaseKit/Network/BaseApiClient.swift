//
//  BaseApiClient.swift
//  BaseKit
//
//  Created by Sungjun Chin on 2021/06/21.
//

import Alamofire
import RxSwift
import Foundation

public protocol ApiClient {
    func sendGet<T: Decodable>(_ urlString: String, parameters: Parameters?) -> Observable<T>
    func sendGet<T: Decodable>(path: String, parameters: Parameters?) -> Observable<T>
    func sendPost<T: Decodable>(_ urlString: String, parameters: Parameters?) -> Observable<T>
    func sendPost<T: Decodable>(path: String, parameters: Parameters?) -> Observable<T>
}

open class BaseApiClient: ApiClient {
    public typealias CompletionHandler<T: Decodable> = ((T?, AFError?) -> ())?
    
    var baseURLConvertible: urlRequestConvertible!
    static let label = "ApiClient"
    static var queue = DispatchQueue.init(label: BaseApiClient.label, qos: .background, attributes: .concurrent)
    
    init(baseUrl: String) {
        baseURLConvertible = urlRequestConvertible(baseUrl)
    }
    
    func setHeaders() {
        
    }
    
    public func sendGet<T: Decodable>(_ urlString: String, parameters: Parameters? = nil) -> Observable<T> {
        let urlConvertible = baseURLConvertible.urlConvertible(urlString: urlString, parameters: parameters)
        return sendRequest(urlConvertible)
    }
    
    public func sendGet<T: Decodable>(path: String, parameters: Parameters? = nil) -> Observable<T> {
        let urlConvertible = baseURLConvertible.urlConvertible(path: path, parameters: parameters)
        return sendRequest(urlConvertible)
    }
    
    public func sendPost<T: Decodable>(_ urlString: String, parameters: Parameters? = nil) -> Observable<T> {
        let urlConvertible = baseURLConvertible.urlConvertible(urlString: urlString, method: .post, parameters: parameters)
        return sendRequest(urlConvertible)
    }
    
    public func sendPost<T: Decodable>(path: String, parameters: Parameters? = nil) -> Observable<T> {
        let urlConvertible = baseURLConvertible.urlConvertible(path: path, method: .post, parameters: parameters)
        return sendRequest(urlConvertible)
    }
    
    private func sendRequest<T: Decodable>(_ urlConvertible: URLRequestConvertible) -> Observable<T> {
        return Observable<T>.create { observer in
            AF.request(urlConvertible).validate()
                .responseDecodable(of: T.self, queue: BaseApiClient.queue) { [weak self] response in
                    self?.onCompleted(observer: observer, response: response)
                }
            
            return Disposables.create {
                
            }
        }
    }
    
    private func onCompleted<T: Decodable>(observer: AnyObserver<T>, response: AFDataResponse<T>) {
        switch response.result {
        case .success:
            guard let data = response.data as? T else { return }
            onSuccess(observer: observer, data: data)
            break
        case .failure:
            guard let error = response.error else { return }
            onError(observer: observer, error: error)
            break
        }
    }
    
    private func onSuccess<T: Decodable>(observer: AnyObserver<T>, data: T) {
        observer.onNext(data)
    }
    
    private func onError<T: Decodable>(observer: AnyObserver<T>, error: AFError) {
        Log.e(error)
        observer.onError(error)
    }
    
}

class urlRequestConvertible: URLRequestConvertible {
    var baseURL: String = ""
    var path: String = ""
    var method: HTTPMethod = .get
    var parameters: Parameters?
    var urlString: String?
    var headers: [String: Any] = [:]

    init(_ baseURL: String) {
        self.baseURL = baseURL
    }
    
    func toHTTPHeaders() -> HTTPHeaders {
        return HTTPHeaders(headers.toString())
    }

    func asURLString() -> String {
        guard let urlString = urlString else {
            return baseURL + path
        }
        
        return urlString
    }
    
    func asURL() throws -> URL {
        guard let url = URL(string: asURLString()) else{
            throw URLError(.badURL)
        }
        return url
    }
    
    func asURLRequest() throws -> URLRequest {
        guard let url = try? asURL() else {
            throw URLError(.cannotConnectToHost)
        }
        
        do {
            var request = try URLRequest(url: url, method: method, headers: toHTTPHeaders())
            
            if let parameters = parameters {
                switch method {
                case .get :
                    request = try URLEncodedFormParameterEncoder().encode(parameters.toString(), into: request)
                case .post:
                    request = try JSONParameterEncoder().encode(parameters.toString(), into: request)
                default: break
                }
            }
            
            return request
        } catch {
            throw error
        }
    }
    
    func urlConvertible(urlString: String, method: HTTPMethod = .get, parameters: Parameters? = nil) -> URLRequestConvertible {
        self.urlString = urlString
        self.method = method
        self.parameters = parameters
        
        return self
    }
    
    func urlConvertible(path: String, method: HTTPMethod = .get, parameters: Parameters? = nil) -> URLRequestConvertible {
        self.path = path
        self.urlString = self.baseURL + path
        self.method = method
        self.parameters = parameters
        
        return self
    }
}



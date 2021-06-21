//
//  BaseApiClient.swift
//  BaseKit
//
//  Created by Sungjun Chin on 2021/06/21.
//

import Alamofire
import Foundation

protocol ApiClient {
    var baseUrl: String { get set }
    var headers: [String:Any] { get set }
    var apiClient: BaseApiClient { get set }
}

class BaseApiClient {
    public typealias CompletionHandler<T: Decodable> = ((T?, AFError?) -> ())?
    
    var baseURLConvertible = urlRequestConvertible("")
    
    func sendGet<T : Decodable>(_ urlString: String, parameters: Parameters?, completionHandler: CompletionHandler<T> = nil) {
        let urlConvertible = baseURLConvertible.urlConvertible(urlString: urlString, parameters: parameters)
        sendRequest(urlConvertible, completionHandler: completionHandler)
    }
    
    func sendGet<T : Decodable>(path: String, parameters: Parameters?, completionHandler: CompletionHandler<T> = nil) {
        let urlConvertible = baseURLConvertible.urlConvertible(path: path, parameters: parameters)
        sendRequest(urlConvertible, completionHandler: completionHandler)
    }
    
    func sendPost<T: Decodable>(_ urlString: String, parameters: Parameters?, completionHandler: CompletionHandler<T> = nil) {
        let urlConvertible = baseURLConvertible.urlConvertible(urlString: urlString, method: .post, parameters: parameters)
        sendRequest(urlConvertible, completionHandler: completionHandler)
    }
    
    func sendPost<T: Decodable>(path: String, parameters: Parameters?, completionHandler: CompletionHandler<T> = nil) {
        let urlConvertible = baseURLConvertible.urlConvertible(path: path, method: .post, parameters: parameters)
        sendRequest(urlConvertible, completionHandler: completionHandler)
    }
    
    func sendRequest<T : Decodable>(_ urlConvertible: URLRequestConvertible, completionHandler: CompletionHandler<T>) {
        AF.request(urlConvertible)
            .validate()
            .responseDecodable { [weak self] response in
                self?.onCompleted(response: response, completionHandler: completionHandler)
            }
    }
    
    func onCompleted<T: Decodable>(response: AFDataResponse<T>, completionHandler: CompletionHandler<T>) {
        guard let data = response.data as? T else {
            if let error = response.error {
                onError(error: error, completionHandler: completionHandler)
            }
            return
        }
        
        completionHandler?(data, nil)
    }
    
    func onError<T: Decodable>(error: AFError, completionHandler: CompletionHandler<T>) {
        Log.e(error)
        completionHandler?(nil, error)
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
        self.method = method
        self.parameters = parameters
        
        return self
    }
}



//
//  RxDataSourceAdaptable.swift
//  BaseKit
//
//  Created by Sungjun Chin on 2021/07/07.
//

import RxSwift

public protocol RxDataSourceAdaptable: AnyObject {
    associatedtype Request: Encodable
    associatedtype Response: Decodable
    
    var client: ApiClient { get set }
    var lastRequest: String? { get set }
    
    var disposeBag: DisposeBag { get set }
    
    func fetchData(urlString: String) -> Observable<Response>
    func fetchData(_ rq: Request, path: String) -> Observable<Response>
    func fetchPage(urlString: String) -> Observable<Response>?
    func fetchPage(_ rq: Request, path: String) -> Observable<Response>?
}

extension RxDataSourceAdaptable {
    public func fetchData(urlString: String) -> Observable<Response> {
        return client.sendGet(urlString, parameters: nil)
    }
    
    public func fetchData(_ rq: Request, path: String) -> Observable<Response> {
        return client.sendGet(path: path, parameters: rq.toParameters())
    }
    
    public func fetchPage(urlString: String) -> Observable<Response>? {
        if let lastRequest = lastRequest, lastRequest == urlString {
            return nil
        }
        return completeFetchPage(client.sendGet(urlString, parameters: nil), urlString: urlString)
    }
    
    public func fetchPage(_ rq: Request, path: String) -> Observable<Response>? {
        if let lastRequest = lastRequest, lastRequest == rq.toString() {
            return nil
        }
        return completeFetchPage(client.sendGet(path: path, parameters: rq.toParameters()), rq: rq)
    }
    
    func completeFetchPage(_ observable: Observable<Response>, urlString: String) -> Observable<Response> {
        observable.asObservable()
            .subscribe(onCompleted: { [weak self] in
                self?.lastRequest = urlString
            }).disposed(by: disposeBag)
        return observable
    }
    
    func completeFetchPage(_ observable: Observable<Response>, rq: Request) -> Observable<Response> {
        observable.asObservable()
            .subscribe(onCompleted: { [weak self] in
                self?.lastRequest = rq.toString()
            }).disposed(by: disposeBag)
        return observable
    }
}

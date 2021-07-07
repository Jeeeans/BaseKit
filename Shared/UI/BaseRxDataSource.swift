//
//  BaseRxDataSource.swift
//  BaseKit
//
//  Created by Sungjun Chin on 2021/06/21.
//

import RxSwift

open class BaseRxDataSource<RQ: Encodable, RP: Decodable>: RxDataSourceAdaptable {
    public typealias Request = RQ
    public typealias Response = RP
    
    public var client: ApiClient
    public var lastRequest: String?
    
    public var disposeBag = DisposeBag()
    
    init(baseUrl: String) {
        client = BaseApiClient(baseUrl: baseUrl)
    }
    
    public func fetchData(urlString: String) -> Observable<RP> {
        return client.sendGet(urlString, parameters: nil)
    }
    
    public func fetchData(_ rq: RQ, path: String) -> Observable<RP> {
        return client.sendGet(path: path, parameters: rq.toParameters())
    }
    
    public func fetchPage(urlString: String) -> Observable<RP>? {
        if let lastRequest = lastRequest, lastRequest == urlString {
            return nil
        }
        return completeFetchPage(client.sendGet(urlString, parameters: nil), urlString: urlString)
    }
    
    public func fetchPage(_ rq: RQ, path: String) -> Observable<RP>? {
        if let lastRequest = lastRequest, lastRequest == rq.toString() {
            return nil
        }
        return completeFetchPage(client.sendGet(path: path, parameters: rq.toParameters()), rq: rq)
    }
    
    func completeFetchPage(_ observable: Observable<RP>, urlString: String) -> Observable<RP> {
        observable.asObservable()
            .subscribe(onCompleted: { [weak self] in
                self?.lastRequest = urlString
            }).disposed(by: disposeBag)
        return observable
    }
    
    func completeFetchPage(_ observable: Observable<RP>, rq: RQ) -> Observable<RP> {
        observable.asObservable()
            .subscribe(onCompleted: { [weak self] in
                self?.lastRequest = rq.toString()
            }).disposed(by: disposeBag)
        return observable
    }
}

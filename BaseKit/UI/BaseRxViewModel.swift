//
//  BaseRxViewModel.swift
//  BaseKit
//
//  Created by Sungjun Chin on 2021/06/21.
//

import RxSwift
import RxRelay

public protocol ViewModel: AnyObject {
    associatedtype Request: Encodable
    associatedtype Response: Decodable
    associatedtype DataSourceType: RxDataSourceAdaptable
    var dataSource: DataSourceType { get set }
}

open class BaseRxViewModel: ViewModel {
    public typealias Request = BaseRequest
    public typealias Response = BaseResponse
    public typealias DataSourceType = BaseRxDataSource<Request, Response>
    public var dataSource: BaseRxDataSource<Request, Response>
    var data = PublishRelay<Response>()
    
    var disposeBag = DisposeBag()
    var pageNo: Int = 1
    var path: String = ""
    
    var request = BaseRequest()
    
    public init() {
        dataSource = BaseRxDataSource<Request, Response>(baseUrl: "")
    }
    
    public func fetchData(_ rq: Request) {
        updateData(dataSource.fetchData(rq, path: path))
    }
    
    public func fetchData(urlString: String) {
        updateData(dataSource.fetchData(urlString: urlString))
    }
    
    public func updateData(_ observable: Observable<Response>?) {
        guard let observable = observable else { return }
        observable.asObservable()
            .subscribe(with: data)
            .disposed(by: disposeBag)
    }
    
    public func fetchPage(urlString: String) {
        updatePage(dataSource.fetchData(urlString: urlString))
    }
    
    public func fetchPage(_ rq: Request) {
        updatePage(dataSource.fetchData(rq, path: path))
    }
    
    public func updatePage(_ observable: Observable<Response>?) {
        guard let observable = observable else { return }
        observable.asObservable()
            .subscribe(onNext: { [weak self] data in
                self?.updatePage(data)
            })
            .disposed(by: disposeBag)
    }
    
    public func updatePage(_ data: Response) {
        
    }
}

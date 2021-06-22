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
    associatedtype DataSourceType: DataSource
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
    
    init() {
        dataSource = BaseRxDataSource<Request, Response>(baseUrl: "")
    }
    
    func fetchData(_ rq: Request) {
        updateData(dataSource.fetchData(rq, path: path))
    }
    
    func fetchData(urlString: String) {
        updateData(dataSource.fetchData(urlString: urlString))
    }
    
    func updateData(_ observable: Observable<Response>?) {
        guard let observable = observable else { return }
        observable.asObservable()
            .subscribe(with: data)
            .disposed(by: disposeBag)
    }
    
    func fetchPage(urlString: String) {
        updatePage(dataSource.fetchData(urlString: urlString))
    }
    
    func fetchPage(_ rq: Request) {
        updatePage(dataSource.fetchData(rq, path: path))
    }
    
    func updatePage(_ observable: Observable<Response>?) {
        guard let observable = observable else { return }
        observable.asObservable()
            .subscribe(onNext: { [weak self] data in
                self?.updatePage(data)
            })
            .disposed(by: disposeBag)
    }
    
    func updatePage(_ data: Response) {
        
    }
}

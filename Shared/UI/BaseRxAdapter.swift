//
//  BaseRxAdapter.swift
//  BaseKit
//
//  Created by Sungjun Chin on 2021/07/01.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa

protocol RxAdapterAdaptable: AnyObject {
    associatedtype Model: Decodable
    func getCellFromIndex(_ indexPath: IndexPath) -> BaseRxUICollectionViewCell<Model>
}

public class BaseRxAdapter {
    private var disposeBag = DisposeBag()
    private var _list = BehaviorRelay<[Decodable]>(value: [])
    private var listObservable: Observable<[Decodable]> { _list.asObservable() }
    var list: [Decodable] { _list.value }
    
    var count: Int = 0

    init() {
        listObservable
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .map{ $0.count }
            .subscribe(onNext: { [weak self] count in
                self?.count = count
            })
            .disposed(by: disposeBag)
    }

    func update(_ observable: Observable<[Decodable]>) {
        observable
            .asDriver(onErrorJustReturn: [])
            .drive(_list)
            .disposed(by: disposeBag)
    }
    
    func item(_ index: Int) -> Decodable? {
        guard index < count else { return nil }
        return list[index]
    }
}

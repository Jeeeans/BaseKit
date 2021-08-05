//
//  BaseRxCollectionViewAdapter.swift
//  BaseKit
//
//  Created by Sungjun Chin on 2021/07/30.
//

import Foundation
import UIKit
import RxSwift
import RxRelay
import RxCocoa

open class BaseRxCollectionViewAdapter {
    var _list = BehaviorRelay<[Decodable]>(value: [])
    
    var disposeBag = DisposeBag()
    var count: Int = 0
    
    var map: [String : String] = [:]

    private var listObservable: Observable<[Decodable]> { _list.asObservable() }
    var list: [Decodable] { _list.value }
    
    func initialize() {
        self.listObservable
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .map{ $0.count }
            .subscribe(onNext: { [weak self] count in
                self?.count = count
            })
            .disposed(by: self.disposeBag)
    }

    func update(_ observable: Observable<[Decodable]>) {
        observable
            .asDriver(onErrorJustReturn: [])
            .drive(_list)
            .disposed(by: disposeBag)
    }
    
    func getCell(_ indexPath: IndexPath) -> UICollectionViewCell? {
        guard let identifier = map[String(describing: list[indexPath.row].self)] else { return nil }
        
        
        return classFromString(identifier)
    }
    
    func size(_ indexPath: IndexPath) -> CGSize {
        guard let cell = getCell(indexPath) as? BaseRxUICollectionViewCell else {
            return .zero
        }
        return .zero
    }
    
    func item(_ index: Int) -> Decodable? {
        guard index < count else { return nil }
        return list[index]
    }

    
    func selectItem(_ indexPath: IndexPath) {
        
    }
}

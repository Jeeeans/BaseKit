//
//  BaseRxAdapter.swift
//  BaseKit
//
//  Created by Sungjun Chin on 2021/07/01.
//

import Foundation
import UIKit
import RxSwift
import RxRelay
import RxCocoa

protocol RxAdapterAdaptable: AnyObject {
//    associatedtype CellType: RxCollectionViewCellAdaptable
    
    var disposeBag: DisposeBag { get set }
    var _list: BehaviorRelay<[Decodable]> { get set }
    var count: Int { get set }
    func getCell(_ indexPath: IndexPath) -> UICollectionViewCell
    func size(_ indexPath: IndexPath) -> CGSize
    func setCellWithModel()
    
    
    var map: [BaseModel:BaseRxUICollectionViewCell] { get set }
}

extension RxAdapterAdaptable {
    
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
    
    func item(_ index: Int) -> Decodable? {
        guard index < count else { return nil }
        return list[index]
    }

    
    func selectItem(_ indexPath: IndexPath) {
        
    }
}

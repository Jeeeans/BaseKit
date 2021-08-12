//
//  BaseCoordinator.swift
//  BaseKit
//
//  Created by Sungjun Chin on 2021/07/29.
//

import Foundation
import UIKit
import RxSwift

public protocol Coordinatable: AnyObject {
    var navigation: BaseNavigationController { get set }
}

extension Coordinatable {
    func push(_ viewController: UIViewController, _ animated: Bool) {
        navigation.pushViewController(viewController, animated: animated)
    }
    
    func pop(_ viewController: UIViewController, _ animated: Bool) {
        navigation.popViewController(animated: animated)
    }
    
    func goHome(_ animated: Bool) {
        navigation.popToRootViewController(animated: animated)
    }
}

public class BaseCoordinator<ResultType> {
    typealias CoordinationResult = ResultType
    
    private let identifier = UUID()
    private var childCoordinators = [UUID: Any]()
    
    var disposeBag = DisposeBag()
    
    
    private func store<T>(coordinator: BaseCoordinator<T>) {
        childCoordinators[coordinator.identifier] = coordinator
    }
    
    private func free<T>(coordinator: BaseCoordinator<T>) {
        childCoordinators[coordinator.identifier] = nil
    }
    
    func coordinate<T>(to coordinator: BaseCoordinator<T>) -> Observable<T> {
        store(coordinator: coordinator)
        return coordinator.start()
            .do(onNext: { [weak self] _ in self?.free(coordinator: coordinator) })
    }
    
    func start() -> Observable<ResultType> {
        fatalError("Start method should be implemented.")
    }
}

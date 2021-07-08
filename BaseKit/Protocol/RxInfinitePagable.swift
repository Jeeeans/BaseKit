//
//  RxInfinitePagable.swift
//  BaseKit
//
//  Created by Sungjun Chin on 2021/06/22.
//

import Foundation
import UIKit

public protocol RxInfinitePagableModel {
    var pageNo: Int { get set }
}

public protocol RxInfinitePager {
    func loadNextPage(_ completion: (() -> ())?)
}

public protocol RxInfinitePagable: AnyObject {
    func updatePageIfNeeded(_ scrollView: UIScrollView)
    var pager: RxInfinitePager? { get set }
    var isPaging: Bool { get set }
}

extension RxInfinitePagable {
    func scrollViewBottomY(_ scrollView: UIScrollView) -> CGFloat {
        return scrollView.contentSize.height - scrollView.bounds.size.height
    }
    
    func isScrollBottom(_ scrollView: UIScrollView) -> Bool {
        let bottomY = scrollViewBottomY(scrollView)
        
        if scrollView.contentOffset.y >= bottomY {
            return true
        }
        
        return false
    }
    
    func updatePageIfNeeded(_ scrollView: UIScrollView, completion: (()->())?) {
        guard let pager = pager else { return }
        
        if scrollView.contentOffset.y >= scrollViewBottomY(scrollView) + scrollView.contentInset.bottom, !isPaging {
            isPaging = true
            pager.loadNextPage { [weak self] in
                completion?()
                self?.isPaging = false
            }
        }
    }
}

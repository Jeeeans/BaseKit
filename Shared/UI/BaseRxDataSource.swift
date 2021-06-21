//
//  BaseRxDataSource.swift
//  BaseKit
//
//  Created by Sungjun Chin on 2021/06/21.
//

import RxSwift

open class BaseRxDataSource<RQ: BaseRequest, RP: BaseResponse> {
    var apiClient: BaseApiClient!
    
    func fetchData(_ rq: RQ) -> RP {
        
    }
}

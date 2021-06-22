//
//  BaseRxViewController.swift
//  BaseKit
//
//  Created by Sungjun Chin on 2021/06/21.
//

import UIKit

open class BaseRxViewController: UIViewController {
    var viewModel: BaseRxViewModel!
    @IBOutlet weak var collectionView: BaseRxUICollectionView!
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initialize()
    }
    
    func initialize() {
        viewModel = BaseRxViewModel()
        initialCollectionView()
    }
    
    func initialCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}




extension BaseRxViewController: UICollectionViewDelegateFlowLayout {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
    }
}

extension BaseRxViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
    }
    
    
}

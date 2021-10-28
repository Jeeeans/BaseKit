//
//  MarginCell.swift
//  BaseKit
//
//  Created by Sungjun Chin on 2021/08/12.
//

import UIKit

public class MarginCell<T: MarginModel>: UICollectionViewCell {
    static func size(_ model: MarginModel) -> CGSize {
        return CGSize(width: UIScreen.screenWidth, height: model.height)
    }

    func configure(_ data: MarginModel) {
        backgroundColor = UIColor(hex: data.backgroundColor)
    }
}

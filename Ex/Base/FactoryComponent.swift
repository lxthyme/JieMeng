//
//  FactoryComponent.swift
//  LXCAAnimation
//
//  Created by John LXThyme on 2017/5/4.
//  Copyright © 2017年 John LXThyme. All rights reserved.
//

import Foundation

let mainBounds = UIScreen.main.bounds

struct MainBounds {
    static let bounds = UIScreen.main.bounds
    static let center = CGPoint(x: MainBounds.width / 2.0, y: MainBounds.height / 2.0)
    static let size = UIScreen.main.bounds.size
    static let width = UIScreen.main.bounds.size.width
    static let height = UIScreen.main.bounds.size.height
}
class Component: NSObject {
    static let mBounds = MainBounds.bounds
    static let mCenter = MainBounds.center
    static let mSize = MainBounds.size
    static let mWidth = MainBounds.width
    static let mHeight = MainBounds.height
}
// MARK: UITableView
extension Component {
    static func _tableView() ->UITableView {
        let table_t: UITableView = {
            let table = UITableView(frame: CGRect.zero, style: .grouped)
            table.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
            table.separatorStyle = .none
            table.showsHorizontalScrollIndicator = false
            table.showsVerticalScrollIndicator = false
            table.estimatedRowHeight = 44
            table.rowHeight = UITableViewAutomaticDimension
            table.contentOffset = CGPoint(x: 0, y: 0)
            return table
        }()
        return table_t;
    }
}
// MARK: UICollectionView
extension Component {
    static func _collectionView(itemSize: CGSize) -> UICollectionView {
        let flowLayout_t: UICollectionViewFlowLayout = {
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.itemSize = itemSize
            flowLayout.estimatedItemSize = itemSize
            flowLayout.minimumLineSpacing = 0
            flowLayout.minimumInteritemSpacing = 0
            flowLayout.scrollDirection = .vertical
            flowLayout.sectionInset = UIEdgeInsets.zero
            let ov = UIDevice.current.systemVersion as NSString
            if ov.floatValue >= 9.0 {
                //            flowLayout.sectionHeadersPinToVisibleBounds = true
                //            flowLayout.sectionFootersPinToVisibleBounds = true
            }
            return flowLayout
        }()
        let collectionView_t: UICollectionView = {
            let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout_t)
            collectionView.backgroundColor = UIColor(fromHexString: "#e4ceb3")
            collectionView.showsVerticalScrollIndicator = false
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.alwaysBounceVertical = true
//            collectionView.delegate = self
//            collectionView.dataSource = self
            return collectionView
        }()

        return collectionView_t
    }
}

// MARK: UIButton
extension Component {
    static func _button() ->UIButton {
        let button_t: UIButton = {
            let btn = UIButton(type: .custom)
            btn.frame = CGRect.zero
            return btn
        }()

        return button_t
    }
}

// MARK: UIImageView
extension Component {
    static func _imgView() ->UIImageView {
        let imgView_t: UIImageView = {
            let imgView = UIImageView()
            imgView.frame = CGRect.zero
            return imgView
        }()

        return imgView_t
    }
}

// MARK: UILabel
extension Component {
    static func _label() ->UILabel {
        let label_t: UILabel = {
            let label = UILabel()
            label.frame = CGRect.zero
            return label
        }()
        return label_t
    }
}

// MARK: UITextField
extension Component {
    static func _textField() ->UITextField {
        let textField_t: UITextField = {
            let textField = UITextField()
            textField.frame = CGRect.zero
            return textField
        }()

        return textField_t
    }
}

//
//  BaseVC.swift
//  MyGitHub
//
//  Created by John LXThyme on 2017/3/29.
//  Copyright © 2017年 John LXThyme. All rights reserved.
//

import UIKit
import SnapKit

class BaseVC: UIViewController, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        self.view.setNeedsLayout()
        self.view.setNeedsUpdateConstraints()
        DispatchQueue.main.async {
            self.extendedLayoutIncludesOpaqueBars = true
            self.automaticallyAdjustsScrollViewInsets = false
            self.edgesForExtendedLayout = []
            self.navigationController?.navigationBar.isTranslucent = false
        }
    }
}
extension BaseVC {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.extendedLayoutIncludesOpaqueBars = true
            self.automaticallyAdjustsScrollViewInsets = false
            self.edgesForExtendedLayout = []
            self.navigationController?.navigationBar.isTranslucent = false
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.delegate=self
        DispatchQueue.main.async {
            self.extendedLayoutIncludesOpaqueBars = true
            self.automaticallyAdjustsScrollViewInsets = false
            self.edgesForExtendedLayout = []
            self.navigationController?.navigationBar.isTranslucent = false
        }

        // 检测设备方向
        NotificationCenter.default.addObserver(self, selector: #selector(receivedRotation(notification:)), name: .UIDeviceOrientationDidChange, object: nil)
    }
    func receivedRotation(notification: NSNotification) {
        rotateUpdateMasonry()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        DispatchQueue.main.async {
            self.extendedLayoutIncludesOpaqueBars = true
            self.automaticallyAdjustsScrollViewInsets = false
            self.edgesForExtendedLayout = []
            self.navigationController?.navigationBar.isTranslucent = false
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
}
// MARK: - UINavigationControllerDelegate
//extension BaseVC {
//    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        if operation == .push {
//            let pushAnimation = PushAnimation()
//            return pushAnimation
//        }else if operation == .pop {
//            let popAnimation = PopAnimation()
//            return popAnimation
//        }
//        return nil
//    }
//}
extension BaseVC {
//    override func loadView(){
//        super.loadView()
//        //设置y从导航栏下开始
//        self.edgesForExtendedLayout = .bottom
//    }
    override func updateViewConstraints() {
        super.updateViewConstraints()
        print("-----updateViewConstraints-----")
        masonry()
    }
    func rotateUpdateMasonry() {
        print("---rotateUpdateMasonry---")
    }
    func masonry() {
        print("---masonry---")
    }
}
// MARK: - UITableViewDataSource
/**
 // MARK: - UITableViewDataSource
 // ,UITableViewDelegate, UITableViewDataSource
 extension BaseVC {
 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 return 1
 }
 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 let cellIdentifier = "cellIdentifier"
 var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
 if cell == nil {
 cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
 }
 return cell!;
 }
 }
 // MARK: - UITableViewDelegate
 extension BaseVC {
 func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 //        tableView.deselectRow(at: indexPath, animated: true)
 }
 }
 */
/**
// MARK: - UICollectionViewDataSource
extension LXMengCategoryVC2 {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ds.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionCellIdentifier, for: indexPath) as! LXMengCategoryCell
        let item = ds[indexPath.item]
        let imgName = "zgjm_big_category_\(item.id).png"
        cell.bgImgView.image = UIImage(named: imgName)
        return cell
    }
}
// MARK: - UICollectionViewDelegate
extension LXMengCategoryVC2 {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = collectionView.frame.size.width
        let height = 354.0 * width / 640.0
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kCollectionHeaderSectionIdentifier, for: indexPath)
            return headerView
        }
        assert(true, "ERROR")
        return UICollectionReusableView()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let cell = collectionView.cellForItem(at: indexPath)!
        cell.backgroundColor = UIColor(patternImage: UIImage(named: "zgjm_category_btn_f.png")!)
        lastSelectedCell?.backgroundColor = UIColor.clear
        lastSelectedCell = cell
        //
        let item = ds[indexPath.item]
        UserDefaults.standard.set(item.categoryName, forKey: kMengTopCategoryNameUserDefaultsKey)
        let secondCategoryVC = LXMengSecondCategoryVC()
        secondCategoryVC.id = item.id
        secondCategoryVC.title = item.categoryName
        var realRect = cell.contentView.convert(cell.contentView.frame, to: self.view)
        realRect.origin.y += 64
        let data = NSKeyedArchiver.archivedData(withRootObject: realRect)
        UserDefaults.standard.set(data, forKey: UserDefaultsKey.parentView.rawValue)
        self.navigationController?.pushViewController(secondCategoryVC, animated: true)
    }
}
*/

//
//  ListVC.swift
//  LXCAAnimation
//
//  Created by John LXThyme on 2017/5/4.
//  Copyright © 2017年 John LXThyme. All rights reserved.
//

import UIKit

let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String

let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)

class ListVC: BaseVC,UITableViewDelegate, UITableViewDataSource {
    lazy var table = {
        return Component._tableView()
    }()
    lazy var ds = {
        return [
            NSStringFromClass(LXTabbarVC.classForCoder()),
            NSStringFromClass(PhotoListVC.classForCoder())
        ]
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }
}
// MARK: - UITableViewDataSource
extension ListVC {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ds.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "cellIdentifier"
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }
        cell?.textLabel?.text = ds[indexPath.row]
        return cell!;
    }
}

// MARK: - UITableViewDelegate
extension ListVC {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let classString = ds[indexPath.row];
        let Class = NSClassFromString(classString)
        var vc = Class?.alloc() as? UIViewController
        if vc == nil {
            vc = storyBoard.instantiateViewController(withIdentifier: classString)
        }
        if vc != nil {
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
}

extension ListVC {
    func setup() {
        table.delegate = self
        table.dataSource = self
        self.view.addSubview(table)
    }
    override func masonry() {
        table.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

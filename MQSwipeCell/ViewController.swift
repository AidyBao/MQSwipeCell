//
//  ViewController.swift
//  MQSwipeCell
//
//  Created by 120v on 2018/9/4.
//  Copyright © 2018年 MQ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var editingIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //调整侧换删除按钮样式
        if let idxPath = self.editingIndexPath {
            self.configSwipeButtons(indexPath: idxPath)
        }
    }

    //MARK: - 调整侧滑删除按钮样式
    func configSwipeButtons(indexPath: IndexPath) {
        if #available(iOS 11.0, *){
            for subView in self.tableView.subviews {
                if subView.isKind(of: NSClassFromString("UISwipeActionPullView")!)  {
                    subView.backgroundColor = UIColor.clear
                    for subsubView in subView.subviews {
                        if subsubView.isKind(of: NSClassFromString("UISwipeActionStandardButton")!) {
                            subsubView.frame = CGRect(x: 0, y: 0, width: subsubView.frame.size.width, height: 100 - 13)
                            subsubView.layer.cornerRadius = 6
                            subsubView.layer.masksToBounds = true
                            subsubView.backgroundColor = UIColor.red
                        }
                    }
                }
            }
        }else{//iOS 11.0以下需要在Cell中实现
            for subView in self.tableView.subviews {
                if subView.isKind(of: NSClassFromString("UITableViewCellDeleteConfirmationView")!)  {
                    
                }
            }
        }
    }

}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 100
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
     func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    
    func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        self.editingIndexPath = indexPath
        self.view.setNeedsLayout()
    }

    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        self.editingIndexPath = nil
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)
        return cell
    }
}


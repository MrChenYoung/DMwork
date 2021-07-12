//
//  ViewController.swift
//  DMwork
//
//  Created by MrChen on 2021/6/18.
//  Copyright © 2021 MrChen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {

    // 退出登录按钮
    private var logoutBtn: UIButton?
    // 列表
    private var tableView: UITableView?
    // 屏幕size
    public let screenSize: CGSize = UIScreen.main.bounds.size
    // 当前用户的账号
    public var userInfo: NSDictionary?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.groupTableViewBackground
        
        // 用户信息
        self.title = "用户信息";
        
        // 退出登录按钮
        self.addLogoutBtn()
        
        // 添加tableView
        self.setupTableView()
    }
    
    // 退出登录按钮
    func addLogoutBtn() {
        let logoutBtn: UIButton = UIButton.init(frame: CGRect.init(x: 15, y: screenSize.height - 90, width: screenSize.width - 30, height: 40))
        logoutBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        logoutBtn.setTitle("退出登录", for: UIControl.State.normal)
        logoutBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        logoutBtn.backgroundColor = UIColor.init(red: 62.0/255.0, green: 144.0/255.0, blue: 247.0/255.0, alpha: 1.0)
        logoutBtn.addTarget(self, action: #selector(logoutAction), for: UIControl.Event.touchUpInside)
        logoutBtn.layer.cornerRadius = 20
        logoutBtn.layer.masksToBounds = true
        self.view.addSubview(logoutBtn)
        self.logoutBtn = logoutBtn
    }
    
    // 添加tableView
    func setupTableView() {
        self.tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: screenSize.width, height: (self.logoutBtn?.frame.minY)!), style: UITableView.Style.grouped)
        self.tableView?.dataSource = self as UITableViewDataSource
        self.tableView?.delegate = self as UITableViewDelegate
        self.view.addSubview(self.tableView!)
    }
    
    // 退出登录
    @objc func logoutAction() {
        // 设置主控制器为登录页面
        let loginCtr: LoginViewController = LoginViewController.init()
        let loginNav: UINavigationController = UINavigationController.init(rootViewController: loginCtr)
        UIApplication.shared.keyWindow?.rootViewController = loginNav
    }
    
    // section个数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // 每个section行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 4
        }else {
            return 1
        }
    }
    
    // 每个cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "cellId") ?? nil
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "cellId")
        }
        
        if indexPath.section == 0 {
            let titles: NSArray = ["用户名","性别","手机号","年龄"]
            cell?.textLabel?.text = titles[indexPath.row] as? String
            
            // 用户名
            let userName: String? = self.userInfo?["account"] as? String
            // 性别
            let sexNumber: NSNumber? = self.userInfo?["sex"] as? NSNumber
            let sex: String = sexNumber?.intValue == 0 ? "女" : "男"
            // 手机号
            let phone: String? = self.userInfo?["phone"] as? String
            // 年龄
            let ageNumber: NSNumber? = self.userInfo?["age"] as? NSNumber
            var age: String = ageNumber?.stringValue ?? "0"
            age = age.appending("岁")
            
            let valueArray: NSArray = [userName ?? "",sex,phone ?? "",age]
            cell?.detailTextLabel?.text = valueArray[indexPath.row] as? String
        }else {
            // 当前位置
            cell?.textLabel?.text = "当前位置"
        }
        
        
        return cell!
    }
    
    // 每个section头部高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }else {
            return 20
        }
    }
    
    // 每个section头部view
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    // 点击每一行
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // 进入当前位置页面
        if indexPath.section == 1 {
            let locationCtr: LocationController = LocationController.init()
            self.navigationController?.pushViewController(locationCtr, animated: true)
        }
    }

}


//
//  LoginRegistbaseController.swift
//  DMwork
//
//  Created by MrChen on 2021/6/18.
//  Copyright © 2021 MrChen. All rights reserved.
//

import UIKit

class LoginRegistBaseCtr: UIViewController {

    // 账号输入框
    public var accountTF: UITextField?
    // 密码输入框
    public var passwordTF: UITextField?
    
    // 屏幕size
    public let screenSize: CGSize = UIScreen.main.bounds.size
    // 状态栏高度
    public let stateBarH: CGFloat = UIApplication.shared.statusBarFrame.height
    // 导航栏高度
    public var navBarH: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navBarH = self.navigationController?.navigationBar.frame.size.height ?? 0
        // 设置子视图
        self.setupSubViews()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // 设置子视图
    func setupSubViews() {
        self.view.backgroundColor = UIColor.white
        
        // 账号输入框
        self.accountTF = UITextField.init(frame: CGRect.init(x: 10, y: stateBarH + self.navBarH + 30, width: screenSize.width - 20, height: 40))
        self.accountTF?.font = UIFont.systemFont(ofSize: 15)
        self.accountTF?.placeholder = "输入账号"
        self.accountTF?.textColor = UIColor.black
        self.setupLeftView(tf: self.accountTF!, icon: "user")
        self.view.addSubview(self.accountTF!)
        // 下划线
        let lineView: UIView = self.createBottomLineView(y: self.accountTF?.frame.maxY ?? 0)
        self.view.addSubview(lineView)
        
        // 密码输入框
        let passY: CGFloat = self.accountTF!.frame.maxY + 20
        self.passwordTF = UITextField.init(frame: CGRect.init(x: 10, y: passY, width: self.accountTF!.frame.size.width, height: self.accountTF!.frame.size.height))
        self.passwordTF?.font = UIFont.systemFont(ofSize: 15)
        self.passwordTF?.placeholder = "输入密码"
        self.passwordTF?.isSecureTextEntry = true
        self.passwordTF?.textColor = UIColor.black
        self.setupLeftView(tf: self.passwordTF!, icon: "pass")
        self.view.addSubview(self.passwordTF!)
        // 下划线
        let lineV: UIView = self.createBottomLineView(y: self.passwordTF?.frame.maxY ?? 0)
        self.view.addSubview(lineV)
        
    }
    
    // 创建下划线条
    func createBottomLineView(y: CGFloat) -> UIView {
        let lineV: UIView = UIView.init(frame: CGRect.init(x: 10, y: y, width: screenSize.width - 20, height: 1))
        lineV.backgroundColor = UIColor.init(red: 231.0/255.0, green: 231.0/255.0, blue: 231.0/255.0, alpha: 1.0)
        return lineV
    }
    
    // 设置输入框左边图标
    func setupLeftView(tf: UITextField, icon: String) {
        let leftV: UIButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        leftV.setImage(UIImage.init(named: icon), for: UIControl.State.normal)
        tf.leftView = leftV
        tf.leftViewMode = UITextField.ViewMode.always
    }
    
    // 显示提示信息
    func showTip(message: String, okAction:@escaping ()->()) {
        let alert: UIAlertController = UIAlertController.init(title: nil, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction.init(title: "确定", style: UIAlertAction.Style.default, handler: { (act) in
            okAction()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    // 检查信息是否填写完整
    func checkInfo() -> String? {
        // 账号
        if self.accountTF?.text?.count == 0 {
            return "请输入账号"
        }
        
        // 密码
        if self.passwordTF?.text?.count == 0 {
            return "请输入密码"
        }
        
        return nil
    }
    
    // 存用户信息
    func saveUserInfo(userInfo: NSDictionary) -> Bool {
        let pathArray: NSArray = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true) as NSArray
        var path: String = pathArray.firstObject as! String
        path = path.appending("/user.plist")
        
        // 保存原有数据
        let allUserInfo: NSMutableArray = NSMutableArray.init(contentsOfFile: path) ?? NSMutableArray.init()
        // 添加新用户数据
        allUserInfo.add(userInfo)
        let writeRes: Bool = allUserInfo.write(toFile: path, atomically: true)
        return writeRes
    }
    
    // 读取用户信息
    func readUserInfo(account: String) -> NSDictionary? {
        let pathArray: NSArray = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true) as NSArray
        var path: String = pathArray.firstObject as! String
        path = path.appending("/user.plist")
        
        // 读取所有用户数据
        let allUserInfo: NSArray = NSArray.init(contentsOfFile: path) ?? []
        for user in allUserInfo {
            let acc: String = (user as! NSDictionary).object(forKey: "account") as! String
            if acc == account {
                return user as? NSDictionary
            }
        }
        
        return nil
    }

}

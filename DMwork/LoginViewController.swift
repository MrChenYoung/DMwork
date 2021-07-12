//
//  LoginViewController.swift
//  DMwork
//
//  Created by MrChen on 2021/6/18.
//  Copyright © 2021 MrChen. All rights reserved.
//

import UIKit

class LoginViewController: LoginRegistBaseCtr {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    override func setupSubViews() {
        super.setupSubViews()
        self.title = "登录"
        
        // 登录按钮
        let btnY: CGFloat = self.passwordTF!.frame.maxY + 40
        let loginBtn: UIButton = UIButton.init(frame: CGRect.init(x: 10, y: btnY, width: self.accountTF!.frame.size.width, height: self.accountTF!.frame.size.height))
        loginBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        loginBtn.setTitle("登录", for: UIControl.State.normal)
        loginBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        loginBtn.backgroundColor = UIColor.init(red: 62.0/255.0, green: 144.0/255.0, blue: 247.0/255.0, alpha: 1.0)
        loginBtn.addTarget(self, action: #selector(loginAction), for: UIControl.Event.touchUpInside)
        self.view.addSubview(loginBtn)
        
        // 注册按钮
        let registBtnY: CGFloat = loginBtn.frame.maxY + 20
        let registBtn: UIButton = UIButton.init(frame: CGRect.init(x: 40, y: registBtnY, width: screenSize.width - 80, height: 30))
        registBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        registBtn.setTitle("没有账号？去注册", for: UIControl.State.normal)
        registBtn.setTitleColor(UIColor.init(red: 62.0/255.0, green: 144.0/255.0, blue: 247.0/255.0, alpha: 1.0), for: UIControl.State.normal)
        registBtn.addTarget(self, action: #selector(registAction), for: UIControl.Event.touchUpInside)
        self.view.addSubview(registBtn)
    }
    
    // 点击登录
    @objc func loginAction() {
        let res: String = self.checkInfo() ?? ""
        if res.count != 0 {
            self.showTip(message: res) {}
        }
        
        // 通过账户查询用户信息
        let user: NSDictionary? = self.readUserInfo(account: (self.accountTF?.text)!)
        if user == nil {
            self.showTip(message: "该账户不存在,请先注册") {
                // 去注册
                self.registAction()
            }
            return
        }
        
        // 用户存在 校验密码
        let pass: String = user?.object(forKey: "password") as! String
        if self.passwordTF?.text == pass {
            // 密码正确 登录成功,进入主页
            let homeCtr: ViewController = ViewController.init()
            // 传递当前用户信息到主界面
            homeCtr.userInfo = user
            let homeNav: UINavigationController = UINavigationController.init(rootViewController: homeCtr)
            UIApplication.shared.keyWindow?.rootViewController = homeNav
        }else {
            // 密码不对
            self.showTip(message: "密码错误,请重试") {}
        }
    }
    
    // 去注册
    @objc func registAction(){
        // 跳转到注册页面
        let registCtr: UIViewController = RegistViewController.init()
        self.navigationController?.pushViewController(registCtr, animated: true)
    }

}

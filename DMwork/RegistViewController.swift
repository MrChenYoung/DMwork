//
//  RegistViewController.swift
//  DMwork
//
//  Created by MrChen on 2021/6/18.
//  Copyright © 2021 MrChen. All rights reserved.
//

import UIKit

class RegistViewController: LoginRegistBaseCtr {

    // 确认密码输入框
    private var passTF: UITextField?
    
    // 手机号输入框
    private var phoneTF: UITextField?
    
    // 选择的性别(0:女 1:男)
    private var sex: Int = 1
    // 选择的年龄
    private var age: Int = 50
    // 当前选择的年龄
    private var currentAgeLabel: UILabel?
    // 是否已婚
    private var isMarried: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    override func setupSubViews() {
        super.setupSubViews()
        self.title = "注册"
        
        // 确认密码输入框
        let passY: CGFloat = self.passwordTF!.frame.maxY + 20
        self.passTF = UITextField.init(frame: CGRect.init(x: 10, y: passY, width: self.accountTF!.frame.size.width, height: self.accountTF!.frame.size.height))
        self.passTF?.font = UIFont.systemFont(ofSize: 15)
        self.passTF?.placeholder = "再次输入密码"
        self.passTF?.isSecureTextEntry = true
        self.passTF?.textColor = UIColor.black
        self.setupLeftView(tf: self.passTF!, icon: "pass")
        self.view.addSubview(self.passTF!)
        // 下划线
        let lineV: UIView = self.createBottomLineView(y: self.passTF?.frame.maxY ?? 0)
        self.view.addSubview(lineV)
        
        // 手机号输入框
        let phoneY: CGFloat = self.passTF!.frame.maxY + 20
        self.phoneTF = UITextField.init(frame: CGRect.init(x: 10, y: phoneY, width: self.accountTF!.frame.size.width, height: self.accountTF!.frame.size.height))
        self.phoneTF?.font = UIFont.systemFont(ofSize: 15)
        self.phoneTF?.placeholder = "输入手机号"
        self.phoneTF?.textColor = UIColor.black
        self.setupLeftView(tf: self.phoneTF!, icon: "phone")
        self.view.addSubview(self.phoneTF!)
        // 下划线
        let lineVi: UIView = self.createBottomLineView(y: self.phoneTF?.frame.maxY ?? 0)
        self.view.addSubview(lineVi)
        
        // 设置其他子视图
        self.setupOtherViews()
    }
    
    // 设置其他子视图
    func setupOtherViews() {
        // 性别
        let sexLabel: UILabel = UILabel.init(frame: CGRect.init(x: 10, y: self.phoneTF!.frame.maxY + 20, width: 40, height: 30))
        sexLabel.text = "性别:"
        sexLabel.font = UIFont.systemFont(ofSize: 14)
        self.view.addSubview(sexLabel)
        // 性别选择
        let sexSegment: UISegmentedControl = UISegmentedControl.init(items: ["男","女"])
        sexSegment.frame = CGRect.init(x: sexLabel.frame.maxX + 10, y: sexLabel.frame.minY, width: 120, height: sexLabel.frame.height)
        sexSegment.selectedSegmentIndex = 0
        sexSegment.addTarget(self, action: #selector(sexSelected), for: UIControl.Event.valueChanged)
        self.view.addSubview(sexSegment)
        
        // 年龄
        let ageLabel: UILabel = UILabel.init(frame: CGRect.init(x: 10, y: sexLabel.frame.maxY + 10, width: 40, height: 30))
        ageLabel.text = "年龄:"
        ageLabel.font = UIFont.systemFont(ofSize: 14)
        self.view.addSubview(ageLabel)
        // 年龄选择
        let ageSlider: UISlider = UISlider.init(frame: CGRect.init(x: ageLabel.frame.maxX + 10, y: ageLabel.frame.minY, width: 120, height: ageLabel.frame.height))
        ageSlider.maximumValue = 100
        ageSlider.minimumValue = 1
        ageSlider.setValue(Float(self.age), animated: false)
        ageSlider.addTarget(self, action: #selector(ageChanged), for: UIControl.Event.valueChanged)
        self.view.addSubview(ageSlider)
        // 当前选择的年龄
        self.currentAgeLabel = UILabel.init(frame: CGRect.init(x: ageSlider.frame.maxX + 10, y: ageLabel.frame.minY, width: 30, height: ageLabel.frame.size.height))
        self.currentAgeLabel?.font = UIFont.systemFont(ofSize: 15)
        self.currentAgeLabel?.text = String(self.age)
        self.view.addSubview(self.currentAgeLabel!)
        
        // 是否已婚
        let marryLabel: UILabel = UILabel.init(frame: CGRect.init(x: 10, y: ageLabel.frame.maxY + 10, width: 70, height: 30))
        marryLabel.text = "是否已婚:"
        marryLabel.font = UIFont.systemFont(ofSize: 14)
        self.view.addSubview(marryLabel)
        // 是否已婚选择
        let marrySwitch: UISwitch = UISwitch.init(frame: CGRect.init(x: marryLabel.frame.maxX + 10, y: marryLabel.frame.minY, width: 80, height: marryLabel.frame.height))
        marrySwitch.isOn = true
        marrySwitch.addTarget(self, action: #selector(marryChange), for: UIControl.Event.valueChanged)
        self.view.addSubview(marrySwitch)
        
        // 注册按钮
        let btnY: CGFloat = marryLabel.frame.maxY + 40
        let registBtn: UIButton = UIButton.init(frame: CGRect.init(x: 10, y: btnY, width: self.accountTF!.frame.size.width, height: self.accountTF!.frame.size.height))
        registBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        registBtn.setTitle("注册", for: UIControl.State.normal)
        registBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        registBtn.backgroundColor = UIColor.init(red: 62.0/255.0, green: 144.0/255.0, blue: 247.0/255.0, alpha: 1.0)
        registBtn.addTarget(self, action: #selector(registAction), for: UIControl.Event.touchUpInside)
        self.view.addSubview(registBtn)
    }
    
    // 选择性别
    @objc func sexSelected(segment: UISegmentedControl){
        self.sex = segment.selectedSegmentIndex == 0 ? 1 : 0;
    }
    
    // 年龄
    @objc func ageChanged(ageSlider: UISlider){
        let v: Int = Int(ageSlider.value)
        self.age = v;
        self.currentAgeLabel?.text = String(v)
    }
    
    // 选择是否已婚
    @objc func marryChange(marrySwitch: UISwitch){
        self.isMarried = marrySwitch.isOn
    }
    
    // 注册点击
    @objc func registAction(){
        let res: String = self.checkInfo() ?? ""
        if res.count != 0 {
            self.showTip(message: res) {}
        }
        
        // 两次输入密码是否相同
        if self.passTF?.text != self.passwordTF?.text {
            self.showTip(message: "两次输入密码不一致,请重新输入") {}
        }
        
        // 写入用户信息到plist
        let userInfo: NSMutableDictionary = NSMutableDictionary.init()
        userInfo.setObject(self.accountTF?.text ?? "", forKey: "account" as NSCopying)
        userInfo.setObject(self.passwordTF?.text ?? "", forKey: "password" as NSCopying)
        userInfo.setObject(self.phoneTF?.text ?? "", forKey: "phone" as NSCopying)
        userInfo.setObject(NSNumber.init(integerLiteral: self.sex), forKey: "sex" as NSCopying)
        userInfo.setObject(NSNumber.init(integerLiteral: self.age), forKey: "age" as NSCopying)
        userInfo.setObject(NSNumber.init(value: self.isMarried), forKey: "married" as NSCopying)
        
        let saveRes:Bool = self.saveUserInfo(userInfo: userInfo)
        if saveRes {
            showTip(message: "注册成功") {
                // 返回登录界面
                self.navigationController?.popViewController(animated: true)
            }
        }else {
            showTip(message: "注册失败") {}
        }
    }
    
    override func checkInfo() -> String? {
        let res: String = super.checkInfo() ?? ""
        if res.count != 0 {
            return res
        }
        
        // 确认密码
        if self.passTF?.text?.count == 0 {
            return "请输入确认密码"
        }
        
        // 手机号
        if self.phoneTF?.text?.count == 0 {
            return "请输入手机号"
        }
        
        return nil
    }

}

//
//  ViewController.swift
//  LYProgressHUD
//
//  Created by discover on 2017/9/22.
//  Copyright © 2017年 。。. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
    @IBAction func click(_ sender: UIButton) {
        
        LYProgressHUD.showText("登录成功")
    }
    @IBAction func clickTwo(_ sender: UIButton) {
        LYProgressHUD.showMessage("")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            LYProgressHUD.hide()
        }
    }
    
    @IBAction func clickThree(_ sender: UIButton) {
        LYProgressHUD.showMessage("加载中...")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            LYProgressHUD.hide()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }


}


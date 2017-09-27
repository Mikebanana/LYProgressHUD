//
//  LYProgressHUD.swift
//  LYProgressHUD
//
//  Created by discover on 2017/9/22.
//  Copyright © 2017年 。。. All rights reserved.
//

import UIKit
let iphoneX = UIScreen.instancesRespond(to:#selector(getter: UIScreen.main.currentMode)) ? __CGSizeEqualToSize(CGSize(width:1125,height:2436), (UIScreen.main.currentMode?.size)!) : false
// 屏幕高度
let screenHeight = iphoneX ? UIScreen.main.bounds.height - 34 : UIScreen.main.bounds.height
// 屏幕宽度
let screenWidth = UIScreen.main.bounds.width

let keyWindow = UIApplication.shared.keyWindow
class LYProgressHUD: UIView {

   lazy var textlabel = UILabel()
    
        var fontSize:CGFloat = 14
  
    var limitLength:CGFloat = 150
  
    var spacing:CGFloat = 20
    var messageSpacing:CGFloat = 30
    var activityIndicatorWidth:CGFloat = 37
    var min:CGFloat = 5
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.7)
       self.layer.cornerRadius = 5
       self.addSubview(self.textlabel)
       self.textlabel.font = UIFont.systemFont(ofSize: fontSize)
       self.textlabel.numberOfLines = 0
       self.textlabel.textColor = UIColor.white
       
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    //显示菊花的
    static func showMessage(_ message:String){
        
        let hud =  LYProgressHUD(frame:CGRect.zero)
      let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        
        keyWindow?.isUserInteractionEnabled = false
        hud.textlabel.text = message
        if message == ""{
               hud.frame = CGRect.init(x: (screenWidth-hud.spacing*2-hud.activityIndicatorWidth)/2.0, y: (screenHeight - hud.spacing*2-hud.activityIndicatorWidth)/2.0, width: hud.spacing*2+hud.activityIndicatorWidth, height: hud.spacing*2+hud.activityIndicatorWidth)
               activityIndicator.center = CGPoint.init(x: hud.frame.width/2.0, y: hud.frame.height/2.0)
        }else{
        let testString = message as NSString
        
        var rect = testString.boundingRect(with: CGSize.init(width: CGFloat(MAXFLOAT), height:hud.fontSize), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize:hud.fontSize)], context: nil)
        if rect.width > hud.limitLength {
            rect = testString.boundingRect(with: CGSize.init(width: hud.limitLength, height:CGFloat(MAXFLOAT) ), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize:hud.fontSize)], context: nil)
        }
            if rect.width <= hud.activityIndicatorWidth{
                   hud.frame = CGRect.init(x: (screenWidth-hud.spacing*2-hud.activityIndicatorWidth)/2.0, y: (screenHeight - hud.spacing*2-hud.activityIndicatorWidth-hud.min-rect.height)/2.0, width: hud.spacing*2+hud.activityIndicatorWidth, height: hud.spacing*2+hud.activityIndicatorWidth+hud.min+rect.height)
            }else {
          
                hud.frame = CGRect.init(x: (screenWidth-rect.width-hud.spacing*2)/2.0, y: (screenHeight - hud.spacing*2-hud.activityIndicatorWidth-hud.min-rect.height)/2.0, width: rect.width+hud.spacing*2, height: hud.spacing*2+hud.activityIndicatorWidth+hud.min+rect.height)
            }
            activityIndicator.frame =  CGRect.init(x:(hud.frame.width - hud.activityIndicatorWidth)/2.0 , y: hud.spacing, width: hud.activityIndicatorWidth, height: hud.activityIndicatorWidth)
            hud.textlabel.frame =  CGRect.init(x: hud.spacing, y:activityIndicator.frame.maxY + hud.min, width: rect.width, height: rect.height)
            
            
        }
        //菊花
       
     
        print(activityIndicator.frame)
         activityIndicator.startAnimating()
         hud.addSubview(activityIndicator)
         keyWindow?.addSubview(hud)
    }
    
    
    
    
    
    //只显示字的
    static func showText(_ text:String){
    
        let hud =  LYProgressHUD(frame:CGRect.zero)
        keyWindow?.isUserInteractionEnabled = false
         hud.textlabel.text = text
        let testString = text as NSString
        
        var rect = testString.boundingRect(with: CGSize.init(width: CGFloat(MAXFLOAT), height:hud.fontSize), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize:hud.fontSize)], context: nil)
        if rect.width > hud.limitLength {
         rect = testString.boundingRect(with: CGSize.init(width: hud.limitLength, height:CGFloat(MAXFLOAT) ), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize:hud.fontSize)], context: nil)
        }
        hud.frame = CGRect.init(x: (screenWidth-rect.width-hud.spacing*2)/2.0, y: (screenHeight - rect.height-hud.spacing*2)/2.0, width: rect.width+hud.spacing*2, height: rect.height+hud.spacing*2)
        
        hud.textlabel.frame =  CGRect.init(x: hud.spacing, y: hud.spacing, width: rect.width, height: rect.height)
        keyWindow?.addSubview(hud)
       
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.hide()
        }
       
        
    }
    static func hide(){
    
        for hud in (keyWindow?.subviews)!{
            if hud.isKind(of: LYProgressHUD.self){
               
                    UIView.animate(withDuration: 0.3, animations: {
                        hud.alpha = 0
                    }) { (isCom) in
                        hud.removeFromSuperview()
                         keyWindow?.isUserInteractionEnabled = true
                    }
                
            }
        }
    }
    
}

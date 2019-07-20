//
//  RoundedButton.swift
//  HReminder
//
//  Created by Joker Hook on 2019/7/7.
//  Copyright © 2019 Joker Hook. All rights reserved.
//
// 使用self.layer.masksToBounds = true时会将阴影部分也去掉，同时如果button太多了，会导致导致的离屏渲染会大大拖慢系统的运行速度，体现在系统动画丢帧上。
// 其实 layer 自身也有个背景色，我们完全可以用它来做 button 的背景色，那么这样的话就可以同时实现圆角和阴影了！

import UIKit

class RoundedButton: UIButton {
    
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    
    override func alignmentRect(forFrame frame: CGRect) -> CGRect {
        return frame.inset(by: padding)
    }
    override func contentRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    override func backgroundRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        return contentRect.inset(by: padding)
    }
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        return contentRect.inset(by: padding)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setShadow()
    }
    
    /**
     @setShadow( )
     设置按钮阴影, 圆角
     */
    func setShadow() {
        self.layer.cornerRadius = 20
        self.layer.shadowOpacity = 0.7
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
    }

}

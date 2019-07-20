//
//  HReminderViewController.swift
//  HReminder
//
//  Created by Joker Hook on 2019/7/7.
//  Copyright © 2019 Joker Hook. All rights reserved.
//

import UIKit

public class HReminderViewController: UIViewController {

    public var delegate: HReminderViewControllerDelegate?
    
    // 判断视图是否已经存在
    private var isReminderExist: Bool = false
    // 设置Reminder视图的标题
    private var reminderTitle: String = "Start from beginning"
    // 设置Reminder视图的背景颜色
    private var reminderBackgroundColor: UIColor = .green
    // 设置Reminder的宽度
    private var widthOfReminder: CGFloat = 140.0
    // 设置Reminder的高度
    private var heightOfReminder: CGFloat = 40.0
    // 设置self.view的顶部约束
    private var viewOfTopConstrian: NSLayoutConstraint!
    // 用来储存父视图
    private var superView: UIView?
    
    @IBOutlet weak var reminderButton: RoundedButton! {
        didSet {
            self.reminderButton.setTitle(reminderTitle, for: .normal)
            // 为了可以显示出阴影，这里使用了reminderButton的layer的背景色来充当reminderButton的背景色
            self.reminderButton.layer.backgroundColor = reminderBackgroundColor.cgColor
        }
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public init() {
        let resourcesBundle = Bundle(for: HReminderViewController.self)
        // 通过XIB文件调用父类构造器
        super.init(nibName: "HReminderViewController",bundle: resourcesBundle)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func reminderButtonTapped(_ sender: Any) {
        hideInView()
        self.delegate?.ReminderViewClose()
    }
    
    /**
     *@showInView( superview: UIView )
     *显示Reminder视图
     */
    public func showInView(superview: UIView) {
        
        self.view.translatesAutoresizingMaskIntoConstraints = false
        
        if !isReminderExist {
            isReminderExist = true
            // 判断当前控件是否有父视图，即控件是否添加到视图中
            if self.view.superview == nil {
                superview.addSubview(self.view)
            }
            if self.superView != nil {
                viewOfTopConstrian.constant = 16
            } else {
                self.superView = superview
                /**
                 *设置自定义视图的初始约束，并调整视图到屏幕之外
                 *这里对视图的顶部的约束采用的是topMargin，是为了适配视图里面有导航栏的情况
                 *使用self.view.center.x = superview.center.x的原因是为了让视图一开始就在父视图的中间
                 */
                self.view.center.x = superview.center.x
                viewOfTopConstrian = NSLayoutConstraint(item: self.view as Any, attribute: .top, relatedBy: .equal, toItem: superview, attribute: .topMargin, multiplier: 1, constant: 16)
                superview.addConstraint(viewOfTopConstrian)
                
                let viewOfXConstrian = NSLayoutConstraint(item: self.view as Any, attribute: .centerX, relatedBy: .equal, toItem: superview, attribute: .centerX, multiplier: 1, constant: 0)
                superview.addConstraint(viewOfXConstrian)
                
                let viewOfHeightContrain = NSLayoutConstraint(item: self.view as Any, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 40)
                self.view.addConstraint(viewOfHeightContrain)
                
                let viewOfWidthContrain = NSLayoutConstraint(item: self.view as Any, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 140)
                self.view.addConstraint(viewOfWidthContrain)
            }
            UIView.animate(withDuration: 0.25, animations: {() in
                superview.layoutIfNeeded()
            })
            
        }
    }
    
    /**
     @hideInView( )
     隐藏Reminder视图
     */
    public func hideInView() {
        isReminderExist = false
        viewOfTopConstrian.constant = -200
        UIView.animate(withDuration: 0.25, animations: {() in
            self.superView!.layoutIfNeeded()
        })
    }
    
    /**
     @setTitle( Reminder title : )
     设置Reminder视图的标题
     */
    public func setTitle(Reminder title: String) {
        reminderTitle = title
    }
    
    /**
     @setReminderBackGroundColor( )
     */
    public func setReminderBackgroundColor(color: UIColor) {
        self.reminderBackgroundColor = color
    }
}

/**
 编写选择控制器的协议, 视图消失之后将要发生的事情
 ReminderViewClose( ) 里面的功能由使用者自己定义，这是一个开放的接口
 */
public protocol HReminderViewControllerDelegate {
    func ReminderViewClose()
}

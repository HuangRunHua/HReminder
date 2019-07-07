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
    private var reminderBackgroundColor: UIColor = .systemGreen
    // 设置Reminder的宽度
    private var widthOfReminder: CGFloat = 140.0
    // 设置Reminder的高度
    private var heightOfReminder: CGFloat = 40.0
    
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
     @showInView( superview: UIView )
     显示Reminder视图
     */
    public func showInView(superview: UIView) {
        // 判断当前控件是否有父视图，即控件是否添加到视图中
        if !isReminderExist {
            isReminderExist = true
            if self.view.superview == nil {
                superview.addSubview(self.view)
            }
            // 调整视图到屏幕之外
            self.view.center = CGPoint(x: superview.center.x,y: -200)
            self.view.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y, width: widthOfReminder, height: heightOfReminder)
            
            reminderAnimate(Y: superview.frame.origin.y + 100)
        }
    }
    
    /**
     @hideInView( )
     隐藏Reminder视图
     */
    public func hideInView() {
        isReminderExist = false
        reminderAnimate(Y: -200)
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
    
    /**
     @reminderAnimate( Y cgfloat: CGFloat )
     设置Reminder视图出现的动画，这里是从上到下，类似Twitter
     */
    func reminderAnimate(Y cgfloat: CGFloat) {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {() -> Void in
            self.view.center = CGPoint(x: self.view.center.x, y: cgfloat)
        }, completion: nil)
    }
    
}

/**
 编写选择控制器的协议, 视图消失之后将要发生的事情
 ReminderViewClose( ) 里面的功能由使用者自己定义，这是一个开放的接口
 */
public protocol HReminderViewControllerDelegate {
    func ReminderViewClose()
}

//
//  ViewController.swift
//  circle
//
//  Created by Jack Wang on 2016/12/5.
//  Copyright © 2016年 Jack Wang. All rights reserved.
//

import UIKit

class CircleViewController: UIViewController {
    
    var backgroundcircleViews = [CircleView]()
    var circleViews = [CircleView]()
    var lastCircleView : UIView!
    var isCanTouched = false
    var scaleView : UIView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        //        开始按钮
        let circle = Circle.fixedCircle()
        circle.center = CGPoint(x: view.bounds.width/2, y: view.bounds.height / 2)
        scaleView =  CircleView(circle: circle)
        view.addSubview(scaleView)
        startButtonAnimation()
        
        
        let startLable = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        startLable.center =  CGPoint(x: scaleView.bounds.width/2, y: scaleView.bounds.height / 2)
        startLable.textAlignment = .center
        scaleView.addSubview(startLable)
        startLable.text = "START"
        startLable.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(begainButtonTapped))
        scaleView.addGestureRecognizer(tap)
        
        
        for _ in 1...10{
            startBackgroundCircleAnimation()
        }
        
        
        let illustrateLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 30))
        illustrateLabel.text = "开始后，找出最后一个出现的圆"
        illustrateLabel.font = UIFont.systemFont(ofSize: 18)
        illustrateLabel.textColor = ColorUtilitys.randomColor()
        illustrateLabel.textAlignment = .center
        illustrateLabel.center = CGPoint(x: view.frame.width/2, y: view.frame.height/2 + 150)
        view.addSubview(illustrateLabel)
        
        
        
        let copyrightLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 30))
        copyrightLabel.text = "版权@JACK"
        copyrightLabel.font = UIFont.systemFont(ofSize: 16)
        copyrightLabel.textColor = ColorUtilitys.randomColor()
        copyrightLabel.textAlignment = .center
        copyrightLabel.center = CGPoint(x: view.frame.width/2, y: view.frame.height/2 + 180)
        view.addSubview(copyrightLabel)

        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
      
    
    }
    
   func begainButtonTapped(){
    
    scaleView.removeFromSuperview()
    for backgroundcircleView in backgroundcircleViews{
        backgroundcircleView.removeFromSuperview()
 
    }
    let playViewController = PlayViewController()
    
 navigationController?.pushViewController(playViewController, animated: true)
    
    }
    
    
    
    

    
//    这个动画的关键是 options 中的三个选项：.CurveEaseInOut 是为了缩放看起来更自然，.Repeat 是使动画一直重复，.Autoreverse 是让动画自动颠倒（也就是放大后的缩小）。缩放是通过改变 view 的 transform 这个属性来实现的。
    private func startButtonAnimation(){
        UIView.animate(withDuration: 1, delay: 0, options: [.curveEaseInOut,.repeat,.autoreverse,.allowUserInteraction], animations: {() -> Void in
            self.scaleView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        } , completion: nil)
    }
    
   
    
    private func startBackgroundCircleAnimation(){
        let circle = Circle.randomCircle()
        //已经 有随机颜色了啊
        let cv  = CircleView(circle: circle)
        self.view.insertSubview(cv, belowSubview: self.scaleView)
        backgroundcircleViews.append(cv)
        
        
        
        cv.alpha = 0
        cv.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        
        let delay = Double( arc4random()) / Double(UINT32_MAX ) * 1
        let duration = Double(arc4random()) / Double( UINT32_MAX) * 4 + 0.5
       weak var weakself = self // block里引用self会造成相互引用，内存泄露。所以声明一个弱引用
        UIView.animate(withDuration: duration, delay: delay, options: [.curveLinear], animations: {() -> Void
            
            in
            cv.alpha = 0.5
            cv.transform = CGAffineTransform(scaleX: 1, y: 1)
            
        }, completion: {(isFinished) -> Void in
            if isFinished{
                UIView.animate(withDuration: duration, delay: delay, options: [.curveLinear], animations: { 
                    cv.alpha = 0
                    cv.transform = CGAffineTransform(scaleX: 2, y: 2)
                }, completion: { (isfinished) in
//                    print("isfinished=",isfinished)  //如果跳转到下个控制器，uiview没有了，isfinished则为假
                    cv.removeFromSuperview()
                    if isFinished{
                        weakself!.startBackgroundCircleAnimation() //嵌套循环

                    }
                })
            }

        })
        
    }
    
    
    
   

}


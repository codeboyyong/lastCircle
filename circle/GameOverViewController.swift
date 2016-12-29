//
//  GameOverViewController.swift
//  circle
//
//  Created by Jack Wang on 2016/12/19.
//  Copyright © 2016年 Jack Wang. All rights reserved.
//

import UIKit

class GameOverViewController: UIViewController {
    
    var score = 0
    var bestScore = 0

    
    override func viewDidLoad() {

       
        
        let circle = Circle.fixedCircle()
        circle.center = CGPoint(x: view.frame.width/2, y: view.frame.height/2 + 150)
        view.backgroundColor = UIColor.white
        
        
        let retryBtn  = CircleView(circle: circle)
        self.view.addSubview(retryBtn)
        
        
        let retryLable = UILabel(frame: CGRect(x: 0, y: 0, width: 70, height: 30))
        retryLable.text = "Retry"
        retryLable.textAlignment = .center
        retryBtn.addSubview(retryLable)
        retryLable.center = CGPoint(x: retryBtn.frame.width/2, y: retryBtn.frame.height/2 )
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(retry))
        retryBtn.addGestureRecognizer(tap)
        
        
        
//        retryBtn.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        
        let delay = Double( arc4random()) / Double(UINT32_MAX ) * 1
        

        
        
        UIView.animate(withDuration: 1, delay: delay, options: [.curveLinear,.repeat,.autoreverse,.allowUserInteraction], animations: {() -> Void
            
            in
            retryBtn.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            
        }, completion: nil)
        
        
        let scoreLable = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        scoreLable.text = "您的分数：\(score)"
        scoreLable.textAlignment = .center
        scoreLable.center = CGPoint(x: view.frame.width/2, y: view.frame.height/2 - 150)
        view.addSubview(scoreLable)
        
       var bestScore = UserDefaults.standard.integer(forKey: "bestScore")

        if score > bestScore{
            bestScore = score
            UserDefaults.standard.set(bestScore, forKey: "bestScore")
            UserDefaults.standard.synchronize()

        }
        let bestHistoryLable = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        bestHistoryLable.text = "历史最好：\(bestScore)"
        bestHistoryLable.textAlignment = .center
        bestHistoryLable.center = CGPoint(x: view.frame.width/2, y: view.frame.height/2 - 120)
        view.addSubview(bestHistoryLable)
        
        
        
    }
    
    
    func retry(){
        self.navigationController?.popToRootViewController(animated: true)
        
        
    }
    
    

    
}

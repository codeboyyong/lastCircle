//
//  ViewController.swift
//  circle
//
//  Created by Jack Wang on 2016/12/5.
//  Copyright © 2016年 Jack Wang. All rights reserved.
//

import UIKit
import AVFoundation

class PlayViewController: UIViewController {
    
    var circleViews = [CircleView]()
    var lastCircleView : CircleView!
    var isCanTouched = false
    var scaleView : UIView!
    var currentLevel = 1
    
    var bgmPlayer:AVAudioPlayer!
    
//    var nextLevelLabel = UILabel()


    

    
    
   override    func viewDidLoad() {
        
    
        super.viewDidLoad()
     view.backgroundColor = UIColor.white
    play(circleNumber: currentLevel+1);
    
    
    
    //load soundEffect and bgm
    let url = Bundle.main.url(forResource: "Clean Soul", withExtension: "mp3")!
    bgmPlayer =  try? AVAudioPlayer(contentsOf: url)
    bgmPlayer.numberOfLoops = -1
    bgmPlayer.play()
    }
    
    

    
    func play(circleNumber:Int){
     
        
        
        isCanTouched = true
        //游戏正文
        let circles = CircleFactory(number:circleNumber).circles
        for circle in circles{

                    let cv = CircleView(circle: circle)
                    if circle === circles.last{
                        lastCircleView = cv
                    }
                    view.addSubview(cv)
        
        
                    //            print("cv为",cv)
                    circleViews.append(cv)
            

        
                }
        updateCountDownProgress(delay: 0, totalTime: 10)

        var nextCircle_delay = 0.0
                for (_,cv) in circleViews.enumerated(){
                    
                    cv.transform = CGAffineTransform.init(scaleX: 0.01, y: 0.01)
                    UIView.animate(withDuration: 3, delay: nextCircle_delay, usingSpringWithDamping: 0.5, initialSpringVelocity: 6, options: .allowUserInteraction, animations: {
        
                        cv.transform = CGAffineTransform.identity
                    }, completion: nil )
        
                        nextCircle_delay = nextCircle_delay + Double( arc4random()) / Double( UINT32_MAX ) * 0.4
  

                }
    }
    


    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isCanTouched == true{
            isCanTouched = false
            let touch =  touches.first
            let point = touch?.location(in: view)
            
            if  lastCircleView.frame.contains(point!){
//                "success"
                self.progressViewWidth.removeFromSuperview()

                nextLevel();
            }else{
              //  "fail"

                lastCircleView.blink(completion: {
                                        self.gotoGameOverController()
                    
                    
                   

                })
                
                
               
                
            }
        }
        
        
        
    }
    func gotoGameOverController(){
        //go to game over
        circleViews.removeAll()
        ////
        let gameOverViewController = GameOverViewController()
        gameOverViewController.score = currentLevel
        self.navigationController?.pushViewController(gameOverViewController, animated: true)
    }
    
    
    
    //    这个动画的关键是 options 中的三个选项：.CurveEaseInOut 是为了缩放看起来更自然，.Repeat 是使动画一直重复，.Autoreverse 是让动画自动颠倒（也就是放大后的缩小）。缩放是通过改变 view 的 transform 这个属性来实现的。
    private func startButtonAnimation(){
        UIView.animate(withDuration: 1, delay: 0, options: [.curveEaseInOut,.repeat,.autoreverse,.allowUserInteraction], animations: {() -> Void in
            self.scaleView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        } , completion: nil)
    }
    
    
    
    
    
    var progressViewWidth : UIView!
    func updateCountDownProgress(delay:Double,totalTime:Double){
        progressViewWidth = UIView(frame: CGRect(x: 0, y: 20, width: 10, height: 2))
        progressViewWidth.backgroundColor = UIColor(red: 0, green: 1, blue: 0, alpha: 0.5)
        view.addSubview(progressViewWidth)
        UIView.animate(withDuration: totalTime, delay: delay, options: .curveLinear, animations: {() -> Void
            in
            let scaleX = self.view.frame.width / self.progressViewWidth.frame.width * 2
            self.progressViewWidth.transform = CGAffineTransform(scaleX: scaleX, y: 1)
            self.progressViewWidth.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.5)
            
        }, completion: {finished -> Void in
            if finished{
                self.lastCircleView.blink(completion: {
                    self.gotoGameOverController()
                    
                })
               
            } else{
                
            }
        })
        
    }
    
    
    
    func nextLevel(){
        
        currentLevel += 1

     let   nextLevelLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        nextLevelLabel.center = self.view.center
        nextLevelLabel.textAlignment = .center
        if #available(iOS 8.2, *) {
            nextLevelLabel.font = UIFont.systemFont(ofSize: 30, weight: 5)
        } else {
            // Fallback on earlier versions
            nextLevelLabel.font = UIFont.systemFont(ofSize: 30)
        }
        nextLevelLabel.text = "LEVEL \(self.currentLevel)"
        self.view.addSubview(nextLevelLabel)
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: .curveLinear, animations: {() -> Void in
            self.lastCircleView.transform = CGAffineTransform(scaleX: 50, y: 50)
            
        }, completion: {finished -> Void in
         
            
            nextLevelLabel.removeFromSuperview()
            for circle in self.circleViews{
                circle.removeFromSuperview()
//                print("emoveFromSupervie=",self.circleViews.count)

            }
            self.circleViews.removeAll()
//            print("动画完成后，circle.count======",self.circleViews.count)
            self.play(circleNumber: self.currentLevel + 1);

            
        
        })
    }
    
    
}


//
//  Circle.swift
//  circle
//
//  Created by Jack Wang on 2016/12/5.
//  Copyright © 2016年 Jack Wang. All rights reserved.
//

import UIKit

class Circle{
    //MARK:---properties
    let color:UIColor
    let radius:Int
    var center:CGPoint
   
    static var minRadius: Int {
        switch ScreenUtils.screenWidthModel() {
        case .Width320, .Width375, .Width414, .Other:
            return 20
        case .Width768:
            return 40
        case .Width1024:
            return 60
        }
    }
    
//
   static var maxRadius:Int{
        switch ScreenUtils.screenWidthModel(){
        case .Width320, .Width375, .Width414, .Other:
            return 50
        case .Width768:
            return 100
        case .Width1024:
            return 150
        }
    }
    
    
    init(color:UIColor,radius:Int,center:CGPoint) {
        self.color = color
        self.radius = radius
        self.center = center
    }
    
   static func randomCircle()->Circle{
        let screenRect = UIScreen.main.bounds
        let screenWidth = Int( screenRect.width)
        let scrrenHeight = Int(screenRect.height)
        
        let randomRadius = minRadius + Int( arc4random_uniform (UInt32 ( maxRadius -  minRadius)))
    let  randomColor =  ColorUtilitys.randomColor()
        
        let x = randomRadius + Int(arc4random_uniform  (UInt32((screenWidth - randomRadius * 2))))
        let y = 20 + randomRadius +  Int(arc4random_uniform(UInt32(scrrenHeight - randomRadius * 2 - 20)))
        let radomPoint = CGPoint(x: x, y: y)
        let circle = Circle(color: randomColor, radius: randomRadius, center: radomPoint)
//    let circle = Circle(color: UIColor.red, radius: randomRadius, center: radomPoint)

    return circle
    }
    
    class func fixedCircle() -> Circle{
            
            let  randomColor =  ColorUtilitys.randomColor()
            
            let center = CGPoint(x: 0, y: 0)
            let circle = Circle(color: randomColor, radius: maxRadius, center: center)
            //    let circle = Circle(color: UIColor.red, radius: randomRadius, center: radomPoint)
            
            return circle
        
    }
    
}
class CircleView:UIView{
    //MARK: INIT
//  override  init(frame: CGRect) {
//        super.init(frame: frame)
//    }
    
    init(circle:Circle){
        let frame = CGRect(x: 0, y: 0, width: circle.radius*2, height: circle.radius*2)
        super.init(frame: frame)
        self.backgroundColor = circle.color
        self.center = circle.center
        self.layer.cornerRadius = CGFloat(circle.radius)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    func blink(completion:@escaping ()->Void){

        let scaleUpAnim = CABasicAnimation(keyPath: "transform.scale")
        scaleUpAnim.toValue = 1.5
        scaleUpAnim.repeatCount = 3
        scaleUpAnim.duration = 0.2
        scaleUpAnim.autoreverses    = true
        CATransaction.begin()
        CATransaction .setCompletionBlock(completion)
        self.layer.add(scaleUpAnim, forKey: nil)
        CATransaction.commit()
        
    }
    
    
}

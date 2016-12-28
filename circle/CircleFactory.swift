//
//  CircleFactory.swift
//  circle
//
//  Created by 王亚杰 on 2016/12/15.
//  Copyright © 2016年 王亚杰. All rights reserved.
//

import Foundation

class CircleFactory:NSObject{
    //static
    let MaxCircleCount = 40    

//    static  let sharedCircleFactory = CircleFactory()
    let RadiusGap = 10
    
//    var circles = [Circle]()  等价于
    var circles:[Circle] = []
    
    
    //private
//    override init() {
//        super.init()
//
//        print("CircleFactory init")
//        self.circles.removeAll()
//        
//        for _ in 1...2{
//            addCircle()
//
//        }
//
//    }
    
    
    
     init(number:Int) {
        super.init()
        
        self.circles.removeAll()
        
        for _ in 1...number{
            addCircle()
            
        }
        
    }
    
    func addCircle(){
        while true {
            let aCircle = Circle.randomCircle()
            if isCircleAvailable(aCircle){
                self.circles.append(aCircle)
                break
            }
//          continue 好像没有用
            
        }
    }
    
    
    func isCircleAvailable(_ aCircle:Circle)->Bool{
        for circle in circles{
            let distance = hypotf(Float(aCircle.center.x - circle.center.x), Float(aCircle.center.y - circle.center.y))
        let radiusLength = Float( aCircle.radius + circle.radius)
            if distance <= radiusLength{
                return false
            }
        }
        return true
    }
    
    
}

//
//  Common.swift
//  circle
//
//  Created by Jack Wang on 2016/12/14.
//  Copyright © 2016年 Jack Wang. All rights reserved.
//

import UIKit

enum ScreenUtils {
    case Width320
    case Width375
    case  Width414
    case Width768  //ipad
    case Width1024  //ipad
    case  Other
    
    
    
   static func screenWidthModel()  -> ScreenUtils{
        let screenWidth = UIScreen.main.bounds.width
        if  screenWidth == 320{
            return .Width320
        }else  if  screenWidth == 375{
            return .Width375
    }else  if  screenWidth == 414{
    return .Width414
        }else  if  screenWidth == 768{
            return .Width768
        }else  if  screenWidth == 1024{
            return .Width1024
        }
        
        
        else{
         return .Other
    }
    }
}



class ColorUtilitys{
   static  func randomColor() -> UIColor {
        
        let color:CGFloat = CGFloat(arc4random_uniform(255)) / 255
        let color1:CGFloat = CGFloat(arc4random_uniform(255))/255
        let color2:CGFloat = CGFloat(arc4random_uniform(255))/255
        return UIColor(red: color, green: color1, blue: color2, alpha: 1);
    }
 
    
}

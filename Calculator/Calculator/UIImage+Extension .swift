//
//  UIImage+Extension .swift
//  Calculator
//
//  Created by Liu Chuan on 2017/12/25.
//  Copyright © 2018年 LC. All rights reserved.
//

import UIKit


// MARK: - 扩展 UIImage
extension UIImage {
    
    /// 利用颜色绘制成新的图片
    ///
    /// - Parameters:
    ///   - color: 颜色
    ///   - size: 尺寸
    /// - Returns: UIImage
    public class func drawPictureWithImage(with color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        
        // 开启图形上下文
        UIGraphicsBeginImageContext(size)
        // 设置颜色
        color.set()
        
        //用下面混合模式,以渐变.效果为歌词逐字依次变为绿色(基于progress的递增)
        //UIRectFillUsingBlendMode(fillRect, kCGBlendModeSourceIn)
        // 直接绘图
        UIRectFill(CGRect(origin: CGPoint.zero, size: size))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        // 关闭图形上下文
        UIGraphicsEndImageContext()
        
        return image
    }
}

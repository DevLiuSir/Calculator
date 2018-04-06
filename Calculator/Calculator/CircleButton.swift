//
//  CircleButton.swift
//  Calculator
//
//  Created by Liu Chuan on 2017/12/25.
//  Copyright © 2017年 LC. All rights reserved.
//

import UIKit

/// 数字高亮颜色
let digitHighlightedColor = UIColor(red: 115/255, green: 115/255, blue: 115/255, alpha: 1.00)

/// 清除\百分比等高亮颜色
let clearAndPercentageHighlightedColor = UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1.00)

/// 等号高亮颜色
let equalHighlightedColor = UIColor(red: 251/255, green: 189/255, blue: 145/255, alpha: 1.00)

/// 运算符默认颜色
let OperatorNormalColor = UIColor(red: 253/255, green: 147/255, blue: 38/255, alpha: 1.00)


/* 想要在 IB 中预览，只需要在自定义的 UIView 加上 @IBDesignable 修饰即可 */


@IBDesignable

/// 圆形按钮
class CircleButton: UIButton {
    
    var currentBtn: [UIButton] = []
    
    var tmpBtn = UIButton()

/*   调用layoutSubviews方法.
     即可以实现对子视图重新布局
*/
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = bounds.size.height * 0.5   // 圆角半径
        layer.masksToBounds = true  // 裁切
        addTarget(self, action: #selector(btnCliecked(_:)), for: .touchDown)
    }
    
    /// 按钮点击事件
    ///
    /// - Parameter btn: UIButton
    @objc private func btnCliecked(_ btn: UIButton) {
       
        UIDevice.current.playInputClick()
        
        switch btn.tag {
        case 0...100:
            btn.setBackgroundImage(UIImage.drawPictureWithImage(with: digitHighlightedColor), for: .highlighted)
        case 110...130:
            btn.setBackgroundImage(UIImage.drawPictureWithImage(with: clearAndPercentageHighlightedColor), for: .highlighted)
        case 140...170:
/*
            // 按钮的状态, 默认为 FALSE (反选效果)
            btn.isSelected = !btn.isSelected
            if btn.isSelected {
                btn.setTitleColor(OperatorNormalColor, for: .selected)
                btn.setBackgroundImage(UIImage.drawPictureWithImage(with: .white), for: .selected)
            }else {
                btn.setTitleColor(.white, for: .normal)
                btn.setBackgroundImage(UIImage.drawPictureWithImage(with: OperatorNormalColor), for: .normal)
            }
*/
            btn.setBackgroundImage(UIImage.drawPictureWithImage(with: equalHighlightedColor), for: .highlighted)
            
        case 180:
            btn.setBackgroundImage(UIImage.drawPictureWithImage(with: equalHighlightedColor), for: .highlighted)
        default:
            break
        }
    }
}


// MARK: - UIInputViewAudioFeedback
/* 播放输入点击
 当用户点击自定义输入视图和键盘附加视图的时候，你可以播放标准的系统键盘点击音。首先，在你的输入视图中采用UIInputViewAudioFeedback协议。然后，当响应该视图的键盘点击的时候调用playInputClick方法。
 */
extension CircleButton: UIInputViewAudioFeedback {
    open var enableInputClicksWhenVisible: Bool {
        return true
    }
}


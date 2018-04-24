//
//  CalculatorController.swift
//  Calculator
//
//  Created by Liu Chuan on 2017/12/25.
//  Copyright © 2017年 LC. All rights reserved.
//

import UIKit

class CalculatorController: UIViewController {
    
    // MARK: - 属性
    
    /// 结果值
    @IBOutlet weak var resultLabel: UILabel!
   
    /// 用户是否正在输入
    var userIsInTyping: Bool = false

    /// 计算对象
    var brain = CalcuatorBrain()
    
    /// 显示数字
    var displayValue: Double {    // 只读属性的简写,直接 return
        get {
            return Double(resultLabel.text ?? "") ?? 0.0
        }
        set {
            if Double(Int(newValue)) == newValue {
                resultLabel.text = String(Int(newValue))
            }else {
                resultLabel.text = String(newValue)
            }
        }
    }
    
    
    // MARK: - 按钮点击
    
    /// 点击数字键
    ///
    /// - Parameter sender: 按钮
    @IBAction func touchDigit(_ sender: UIButton) {
        /// 通过tag值,获取清除按钮
        let clearBtn = view.viewWithTag(110) as! UIButton
        // 设置清除按钮文字
        clearBtn.setTitle("C", for: .normal)
        
        /// 获取按钮的当前文字
        guard let digit = sender.currentTitle else { return }
        
        /// 获取label当前显示数值
        guard let textCurrentInDisplay = resultLabel.text else { return }
        
        /// 根据设置的tag值,获取 ( 小数点按钮 )
        let decimalBtn = sender.viewWithTag(10)
        
        // 如果不是小数点按钮
        if sender.tag != decimalBtn?.tag {
            if userIsInTyping {
                resultLabel.text = textCurrentInDisplay + digit
            }else {
                resultLabel.text = digit
                userIsInTyping = true
            }
        }else {     //如果当前是小数点按钮
            /// 判断是否包含字符 '.'
            let subStr = textCurrentInDisplay.contains(".")
            if subStr {
                print("小数点已存在....")
            }else {
                resultLabel.text = textCurrentInDisplay + digit
            }
        }
    }
    
    /// 执行操作键
    ///
    /// - Parameter sender: 按钮
    @IBAction func performOperation(_ sender: UIButton) {
        
        /// 通过tag值,获取清除按钮
        let clearBtn = view.viewWithTag(110) as! UIButton
        // 设置清除按钮文字
        clearBtn.setTitle("AC", for: .normal)
        
        // 1.设置操作数
        if userIsInTyping {
            brain.setOperand(displayValue)
            // 设置完操作符之后，需要接受第二个操作数
            userIsInTyping = false
        }
        // 2.执行计算
        brain.performOperation(sender.currentTitle!)
        
        // 3.获取结果
        if let result = brain.result {
            displayValue = result
        }
    }
    
}

// MARK: - EXtension
extension CalculatorController {
    // MARK: 配置状态栏
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

//
//  CalcuatorBrain.swift
//  Calculator
//
//  Created by Liu Chuan on 2017/12/25.
//  Copyright © 2017年 LC. All rights reserved.
//

import Foundation

struct CalcuatorBrain {
    
    /// 操作数
    private var operand: Double?
    
    /// 等待中的操作数
    private var pendingOperation: PendingBinaryOperation?
    
    /// 结果
    private(set) var result: Double? {
        // 当我们的结果发生改变时候，我们将它设置为: 下次可能作为的操作数
        // 这样可以继续 接着 计算其他的
        didSet {
            if result != nil {
                operand = result!
            }
        }
    }
    
    /// 设置操作数
    mutating func setOperand(_ operand: Double) {
        self.operand = operand
        result = operand
    }
    
    /// 执行计算
    ///
    /// - Parameter symbol: 符号
    mutating func performOperation(_ symbol: String) {
        
        /// 运算
        guard let operation = operations[symbol] else { return }
        
        switch operation {
        case .constant(let value):
            result = value
            pendingOperation = nil
        case .unary(let function):
            if operand != nil {
                result = function(operand!)
            }
        case .binary(let function):
            // 如果是二元 操作，要先记录下 第一个操作数，和操作符
            if operand != nil {
                pendingOperation = PendingBinaryOperation(firstOperand: operand!, operation: function)
                result = nil
            }
        case .equal:
            if pendingOperation != nil && operand != nil {
                result = pendingOperation?.perform(with: operand!)
            }
        }
    }
    
    /// 等待中的操作数和操作符
    private struct PendingBinaryOperation {
        let firstOperand: Double
        let operation: (Double, Double) -> Double
        func perform(with secoundOperand: Double) -> Double {
            return operation(firstOperand,secoundOperand)
        }
    }
    
    /// 定义操作类型
    ///
    /// - constant: 常量操作
    /// - unary->Double: 一元操作
    /// - binary->Double: 二元操作
    /// - equal: ..equal
    private enum Operation {
        /// 常量操作
        case constant(Double)
        /// 一元操作
        case unary((Double) -> Double)
        /// 二元操作
        case binary((Double,Double) -> Double)
        /// ..equal
        case equal
    }
    
    /// 定于 操作符 对应的操作
    private var operations: [String: Operation] = [
        "AC"  :   .constant(0),   // 清空，直接返回0
        "⁺∕-" :   .unary({-$0}),
        "%"   :   .unary({$0 / 100}),
        "+"   :   .binary( + ),
        "−"   :   .binary( - ),
        "×"   :   .binary( * ),
        "÷"   :   .binary( / ),
        "="   :   .equal,
    ]
    
}

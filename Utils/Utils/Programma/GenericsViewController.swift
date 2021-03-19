//
//  GenericsViewController.swift
//  Utils
//
//  Created by liuhongli on 2021/3/12.
//

import UIKit


/*
 Generics:
 
 泛型可以将类型参数化
 
 关联类型的作用：给协议中用到的类型定义一个占位名称
 
 协议中可以拥有多个关联类型
 
 */

class GenericsViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        initial()
    }
    
    func initial() {
        swapValues(&n1, &n2)
        
        
    }
    
    
    
    var n1 = 10
    var n2 = 20
    
//    func swapValues<T>(_ a: inout T, _ b: inout T) {
//        (a, b) = (b, a)
//    }
    func swapValues<T>(_ a: inout T, _ b: inout T) {
        (a, b) = (b, a)
    }
    
    var stack = Stack<Int>()
    
}

class SubStack<E>: Stack<E> {
    
}



class Stack<E> {
    var elements = [E]()
    
    func push(_ element: E) {
        elements.append(element)
    }
    
    
    func pop() -> E {
        elements.removeLast()
    }
    
    func top() -> E? {
        elements.last
    }
    
    func size() -> Int {
        elements.count
    }
    
}


//struct Stack<E> {
//    var elements = [E]()
//    mutating func push(_ element: E) { elements.append(element) }
//    mutating func pop() -> E { elements.removeLast() }
//    func top() -> E { elements.last! }
//    func size() -> Int { elements.count }
//}

enum Score<T> {
    case point(T)
    case grade(String)
}
let score0 = Score<Int>.point(100)
let score1 = Score.point(99)
let score2 = Score.point(99.5)
let score3 = Score<Int>.grade("A")   //必须初始化泛型类型




//protocol Stackable {
//    associatedtype Element //关联类型
//    //associatedtype Element2 //关联类型
//    mutating func push(_ element: Element)
//    mutating func pop() -> Element
//    func top() -> Element
//    func size() -> Int
//}
//
//class StringStack : Stackable {
//    //给关联类型设定真实类型
//    //typealias Element = String
//    var elements = [String]()
//    func push(_ element: String) { elements.append(element) }
//    func pop() -> String { elements.removeLast() }
//    func top() -> String { elements.last! }
//    func size() -> Int { elements.count }
//}


protocol Stackable {
    associatedtype Element: Equatable
}
class Stack2<E: Equatable> : Stackable {
//    typealias Equatable = E

    typealias Element = E

    func equal<S1: Stackable, S2: Stackable>(_ s1: S1, _ s2: S2) -> Bool where S1.Element == S2.Element, S1.Element : Hashable {
        return false
    }
}


protocol Runnable {
    associatedtype Speed
    var speed: Speed { get }
}
class Person : Runnable {
    var speed: Double { 0.0 }
}
class Car : Runnable {
    var speed: Int { 0 }
   func run()  {}
    
    
    
    func get222<T: Runnable>(_ type: Int) -> T {
        if type == 0 {
            return Student() as! T
        }
        return Person() as! T
    }
    
    func aa() {
        
        
//        var rq1 = get(1)
        
//        r1.speed
        
        var r1 = get(0)
    }
}

struct Student {
    
}










func get(_ type: Int) -> some Runnable {
    //if type == 0 {
    //    return Student()
    //}
    return Person()
}



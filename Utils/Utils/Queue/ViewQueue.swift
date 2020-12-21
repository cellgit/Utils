//
//  ViewQueue.swift
//  Utils
//
//  Created by liuhongli on 2020/12/21.
//

import Foundation

struct QueueObject {
    /// 根据优先级进行依次弹出,优先级越高越先弹出
    var priority: Int = 50000
    var object: AnyObject?
}

class ViewQueue {
    
//    var left: [AnyObject]
//    var right: [AnyObject]
    var left: [QueueObject]
    var right: [QueueObject]
    var isEmpty: Bool { return left.isEmpty && right.isEmpty }
    var size: Int { return left.count + right.count }
    var peek: QueueObject? { return left.isEmpty ? right.first : left.last }
    
    
    
    init() {
        left = [QueueObject]()
        right = [QueueObject]()
    }
    
    func enqueue2(object: QueueObject) {
        right.append(object)
    }
    
    func enqueue(object: QueueObject) ->[QueueObject] {
        right.append(object)
        /// 进行排序
        right.sort { (s1, s2) -> Bool in
            return s1.priority > s2.priority
        }
        return right
    }

    func dequeue() -> QueueObject? {
        if left.isEmpty {
            left = right.reversed()
            right.removeAll()
        }
        
        if !left.isEmpty {
            return left.removeLast()
        } else {
            return nil
        }
    }
}

//
//  Linked_List.swift
//  swift_algorithm_club
//
//  Created by 平川冬尉 on 2020/04/26.
//  Copyright © 2020 hirakawa. All rights reserved.
//

import Foundation


// 2分探索木のクラス
public class BinarySearchTree<T: Comparable & CustomStringConvertible> {
    var value: T
    var left: BinarySearchTree? = nil
    var right: BinarySearchTree? = nil
    var parent: BinarySearchTree? = nil

    init(_ v: T) {
        value = v
    }
    
    // プレオーダーで探索するメソッド
    public func preOrderPrint() {
        print(value.description)
        if let left = left {  // leftはインスタンス変数
            left.preOrderPrint()
        }
        if let right = right {
            right.preOrderPrint()
        }
    }
    
    // 引数を持つノードが存在するかを返すメソッド
    public func search(v: T) -> Bool {
        if v == value {  // valueはインスタンス変数
            return true
        } else if v < value {
            if let left = left {
                return left.search(v: v)
            } else {
                return false
            }
        } else {
            if let right = right {
                return right.search(v: v)
            } else {
                return false
            }
        }
    }
    
    //  ノードが葉であれば挿入するメソッド(引数は値)
    // こいつはのちに使えそう
    func add(_ v: T) {
        if v < self.value {
            if let left = left {
                left.add(v)
            } else {
                left = BinarySearchTree(v)
                left?.parent = self
            }
        } else {
            if let right = right {
                right.add(v)
            } else {
                right = BinarySearchTree(v)
                right?.parent = self
            }
        }
    }
    
}



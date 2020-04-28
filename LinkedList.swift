//
//  Linked_List.swift
//  swift_algorithm_club
//
//  Created by 平川冬尉 on 2020/04/26.
//  Copyright © 2020 hirakawa. All rights reserved.
//

import Foundation

// ノードのクラス(LinkedListで呼び出す)
// ジェネリック関数にする
public class Node<T> {
    
    // ジェネリック化
    var value: T
    var next: Node<T>?
    weak var previous: Node<T>?
     
    // ジェネリック化
    init(value: T) {
        self.value = value
    }
 
}

// リンクリストのクラス
// ジェネリック化
public class LinkedList<T> {
    fileprivate var head: Node<T>?
    private var tail: Node<T>?
    
    public var isEmpty: Bool {
        return head == nil
    }
    
    public var first: Node<T>? {
        return head
    }
    
    public var last: Node<T>? {
        return tail
    }
    
    public func append(value: T) {
        // Nodeクラスのインスタンスを定数で作成する
        let newNode = Node(value: value)
        
        // tailがnilじゃない場合の処理とnilの時
        if let tailNode = tail {
            newNode.previous = tailNode
            tailNode.next = newNode
        } else {
            head = newNode
        }
        
        // 末尾に新しいNodeを入れる
        tail = newNode
    }
    
    // インデックスに一致するノードを返すメソッド
    public func nodeAt(index: Int) -> Node<T>? {
        // 引数が0以上の時に検索を実行
        if index >= 0 {
            var node = head  //headはインスタンス変数
            var i = index    //indexは引数
            // 渡されたindex回ループを実行する(かつ、ノードがnilではない)
            while node != nil {
                if i == 0 { return node }
                i -= 1
                node = node!.next
            }
        }
        // ここまできたらnilを返す
        return nil
    }
    
    // すべてのノードを削除するメソッド
    public func removeAll() {
        head = nil
        tail = nil
    }
    
    // どっかのノードを削除するメソッド
    public func remove(node: Node<T>) -> T {
        // nodeは引数として渡される
        let prev = node.previous
        let next = node.next
        
        if let prev = prev {
            prev.next = next // prevがnilじゃなければprevの次ノードをnextへ
        } else {
            head = next // 削除ノードのprevがnilの時は、先頭なので、先頭をその次につなぎ変え
        }
        next?.previous = prev // 削除ノードの次ノードのprevを削除ノードのprevへ
        
        if next == nil {
            tail = prev // 削除ノードのnextがない場合は、末尾なので、末尾を削除ノードのprevにする
        }
        
        // 削除ノードを抹殺
        node.previous = nil
        node.next = nil
        
        return node.value  // 削除ノードを返す
    }
    
}

// 出力を見やすくするためのLinkedListの拡張
extension LinkedList: CustomStringConvertible {
    public var description: String {
        var text = "["
        var node = head
        while node != nil {
          text += "\(node!.value)"
          node = node!.next
          if node != nil { text += ", " }
        }
        return text + "]"
    }
}

// 値の出力をしてみるぜ
public func print_console(){
    // リンクドリストのインスタンスを作成する
    let dogBreeds = LinkedList<String>()
    dogBreeds.append(value: "Labrador")
    dogBreeds.append(value: "Bulldog")
    dogBreeds.append(value: "Beagle")
    dogBreeds.append(value: "Husky")
    
    print(dogBreeds)
    
    dogBreeds.removeAll()
    print(dogBreeds)
    
    let numbers = LinkedList<Int>()
    numbers.append(value: 5)
    numbers.append(value: 10)
    numbers.append(value: 15)
    print(numbers)
}


import Foundation


// ノードクラス
class Tree_Node {
    var value: String
    var children: [Tree_Node] = []
    weak var parent: Tree_Node?
    
    //  valueのイニシャライザ
    init(value: String) {
        self.value = value
    }
    
    // 子を追加するメソッド
    func add(child: Tree_Node) {
        children.append(child)
        child.parent = self
    }
    
    
}

// Tree_Nodeクラスの拡張をして、CustomStringConvertible型を付与
extension Tree_Node: CustomStringConvertible {
    // description変数を用意
    var description: String {
        var text = "\(value)"
        if !children.isEmpty {
            text += " {" + children.map { $0.description }.joined(separator: ", ") + "} "
        }
        return text
    }
}

// Tree_Nodeクラスの拡張をして、ある値を持つノードを探す関数の実装
extension Tree_Node {
  func search(value: String) -> Tree_Node? {
    if value == self.value {
      return self
    }
    // 子ノードを再帰的に探していく
    for child in children {
      if let found = child.search(value: value) {
        return found
      }
    }
    // 見つからない場合はnilを返す
    return nil
  }
}


public func debug_tree(){
    // rootノードには名前の総称を定義する
    let beverages = Tree_Node(value: "beverages")

    let hotBeverages = Tree_Node(value: "hot")
    let coldBeverages = Tree_Node(value: "cold")
    
    beverages.add(child: hotBeverages)
    beverages.add(child: coldBeverages)
    
    print(beverages)
    
    print(beverages.search(value: "hot")) // returns the "cocoa" node
    print(beverages.search(value: "chai")) // returns the "chai" node
    print(beverages.search(value: "bubbly")) // returns nil
}

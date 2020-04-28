import Foundation


// トーナメントノードクラス
class TournamentNode {
    var name: [String]
    var level: Int  // 自分の階層を保持しておく
    var seed_num: Int
    var from: String?
    var children: [TournamentNode] = []  // 0:左, 1:右
    weak var parent: TournamentNode?
    var is_play: Bool = false
    
    //  valueのイニシャライザ
    init(seed_num: Int, level: Int, from: String?) {
        self.name = []
        self.seed_num = seed_num
        self.level = level
        self.from = from
    }
    
    
    // parentを設定するメソッド
    func set_parent(parent: TournamentNode){
        self.parent = parent
    }
    
    
    func make_tournament_box(value: TournamentNode, level: Int) {
        if self.level >= level {
            return
        }
        
        if value.children.isEmpty {
            if level == 1 {
                let left = TournamentNode(seed_num: 1, level: level, from: "left")
                left.set_parent(parent: value)
                value.children.append(left)
                let right = TournamentNode(seed_num: 2, level: level, from: "right")
                right.set_parent(parent: value)
                value.children.append(right)
            } else {
                let k = pow(2.0, Double(level)) + 1.0
                let k2 = Int(k)
                if value.from == "left"{
                    // 左側の子ノードには同じseed_numを与える
                    let left = TournamentNode(seed_num: value.seed_num, level: level, from: "left")
                    left.set_parent(parent: value)
                    value.children.append(left)
                    // 右側の子ノードには自分のk-seed_numを与える
                    let right = TournamentNode(seed_num: k2-value.seed_num, level: level, from: "right")
                    right.set_parent(parent: value)
                    value.children.append(right)
                } else { // 上と逆の処理
                    let left = TournamentNode(seed_num: k2-value.seed_num, level: level, from: "left")
                    left.set_parent(parent: value)
                    value.children.append(left)
                    let right = TournamentNode(seed_num: value.seed_num, level: level, from: "right")
                    right.set_parent(parent: value)
                    value.children.append(right)
                }
            }
        }
        
        // 着目している要素に子がいる場合はその子に関して着目する
        for child in children {
            child.make_tournament_box(value: child, level: level)
        }
        
    }
    
 
// Decimal to Int
//let size = Decimal(2)
//let test = pow(size, 2) - 1
//let result = NSDecimalNumber(decimal: test)
//print(Int(result))
//let decimalToInt = (yourDecimal as NSDecimalNumber).intValue

    // 子ノードを再帰的に探していく
//    for child in children {
//      if let found = child.search(value: value) {
//        return found
//      }
    
    func get_box_num(participant_num: Int) -> Decimal {
        var i: Int
        i = 1
        while true {
            let j = pow(2, i)
            if Decimal(participant_num) < j {return j}
        }
    }
    
}

// Tree_Nodeクラスの拡張をして、CustomStringConvertible型を付与
extension TournamentNode: CustomStringConvertible {
    // description変数を用意
    var description: String {
        var text = "(\(seed_num),\(level))"
        if !children.isEmpty {
            text += " {" + children.map { $0.description }.joined(separator: ", ") + "} "
        }
        return text
    }
}



// Tree_Nodeクラスの拡張をして、ある値を持つノードを探す関数の実装
//extension TreeNode {
//  func search(value: String) -> TreeNode? {
//    if value == self.value {
//      return self
//    }
//    // 子ノードを再帰的に探していく
//    for child in children {
//      if let found = child.search(value: value) {
//        return found
//      }
//    }
//    // 見つからない場合はnilを返す
//    return nil
//  }
//}


public func debug_tournament(){
    print("\n")
    print(pow(3, 4))
    print(type(of: pow(3,4)))   // rootノードには名前の総称を定義する
    
    let tournament = TournamentNode(seed_num: -1, level: 0, from: nil)
    print(tournament)
    tournament.make_tournament_box(value: tournament, level: 1)
    print(tournament)
    tournament.make_tournament_box(value: tournament, level: 2)
    print(tournament)
    tournament.make_tournament_box(value: tournament, level: 1)
    print(tournament)
    //tournament.make_tournament_box(value: tournament, level: 0)
//    let beverages = TreeNode(value: "beverages")
//
//    let hotBeverages = TreeNode(value: "hot")
//    let coldBeverages = TreeNode(value: "cold")
//
//    beverages.add(child: hotBeverages)
//    beverages.add(child: coldBeverages)
//
//    print(beverages)
//
//    print(beverages.search(value: "hot")) // returns the "cocoa" node
//    print(beverages.search(value: "chai")) // returns the "chai" node
//    print(beverages.search(value: "bubbly")) // returns nil
}

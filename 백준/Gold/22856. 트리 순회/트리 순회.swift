import Foundation

final class Node {
    let value: Int
    
    var leftChild: Node?
    var rightChild: Node?
    
    init(value: Int, leftChild: Node? = nil, rightChild: Node? = nil) {
        self.value = value
        self.leftChild = leftChild
        self.rightChild = rightChild
    }
    
    func calculateLeftNodes() -> Int {
        if self.leftChild == nil && self.rightChild == nil { return 0 }
        
        var answer = 0
        
        if let leftChild = self.leftChild {
            answer += leftChild.calculateLeftNodes()
            answer += 2
        }
        
        if let rightChild = self.rightChild {
            answer += rightChild.calculateLeftNodes()
            answer += 2
        }
        
        return answer
    }
    
    func calculateRightNodes() -> Int {
        if self.leftChild == nil && self.rightChild == nil { return 0 }
        
        var answer = 0
        
        if let leftChild = self.leftChild {
            answer += leftChild.calculateLeftNodes()
            answer += 2
        }
        
        if let rightChild = self.rightChild {
            answer += rightChild.calculateRightNodes()
            answer += 1
        }
        
        return answer
    }
}

struct Tree {
    var nodes: [Node] = []
    
    init(n: Int) {
        for x in 0...n {
            nodes.append(Node(value: x))
        }
    }
    
    func insertLeft(by head: Int, left: Int) {
        nodes[head].leftChild = nodes[left]
    }
    
    func insertRight(by head: Int, right: Int) {
        nodes[head].rightChild = nodes[right]
    }
}

let n = Int(readLine()!)!
let tree = Tree(n: n)
var isVisited: [Bool] = Array(repeating: false, count: n + 1)

for _ in 0..<n {
    let infos = readLine()!.split(separator: " ").map { Int($0)! }
    
    if infos[1] != -1 {
        tree.insertLeft(by: infos[0], left: infos[1])
    }
    
    if infos[2] != -1 {
        tree.insertRight(by: infos[0], right: infos[2])
    }
}

var answer = 0

if let value = tree.nodes[1].leftChild?.calculateLeftNodes() {
    answer += value
    answer += 2
}

if let value = tree.nodes[1].rightChild?.calculateRightNodes() {
    answer += value
    answer += 1
}

print(answer)

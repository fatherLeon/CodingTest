class BinaryTree {
    var value: String
    var leftChild: BinaryTree?
    var rightChild: BinaryTree?
    
    init(value: String, leftChild: BinaryTree? = nil, rightChild: BinaryTree? = nil) {
        self.value = value
        self.leftChild = leftChild
        self.rightChild = rightChild
    }
    
    func appendLeftChild(_ node: BinaryTree) {
        if node.value != "." {
            self.leftChild = node
        }
    }
    
    func appendRightChild(_ node: BinaryTree) {
        if node.value != "." {
            self.rightChild = node
        }
    }
    
    func preorderTraversal(visit: (String) -> Void) {
        visit(self.value)
        leftChild?.preorderTraversal(visit: visit)
        rightChild?.preorderTraversal(visit: visit)
    }
    
    func inorderTraversal(visit: (String) -> Void) {
        leftChild?.inorderTraversal(visit: visit)
        visit(self.value)
        rightChild?.inorderTraversal(visit: visit)
    }
    
    func postorderTraversal(visit: (String) -> Void) {
        leftChild?.postorderTraversal(visit: visit)
        rightChild?.postorderTraversal(visit: visit)
        visit(self.value)
    }
}

let n = Int(readLine()!)!
var trees: [BinaryTree] = []

for _ in 0..<n {
    let inputs = readLine()!.split(separator: " ").map { String($0) }
    let root = BinaryTree(value: inputs[0])
    let left = BinaryTree(value: inputs[1])
    let right = BinaryTree(value: inputs[2])
    
    if let treeRoot = trees.first(where: { node in
        if node.value == root.value { return true }
        else { return false }
    }) {
        treeRoot.appendLeftChild(left)
        treeRoot.appendRightChild(right)
        
        trees.append(left)
        trees.append(right)
    } else {
        root.appendLeftChild(left)
        root.appendRightChild(right)
        
        trees.append(root)
        trees.append(left)
        trees.append(right)
    }
}

trees[0].preorderTraversal { value in
    if value != "." {
        print(value, terminator: "")
    }
}
print()
trees[0].inorderTraversal { value in
    if value != "." {
        print(value, terminator: "")
    }
}
print()
trees[0].postorderTraversal { value in
    if value != "." {
        print(value, terminator: "")
    }
}
print()

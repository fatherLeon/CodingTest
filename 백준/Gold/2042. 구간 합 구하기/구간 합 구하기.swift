import Foundation

final class SegmentTree<T> {
    var value: T
    var function: (T, T) -> T
    var leftBounds: Int
    var rightBounds: Int
    var leftChild: SegmentTree<T>?
    var rightChild: SegmentTree<T>?
    
    init(array: [T], leftBounds: Int, rightBounds: Int, function: @escaping (T, T) -> T) {
        self.leftBounds = leftBounds
        self.rightBounds = rightBounds
        self.function = function
        
        if leftBounds == rightBounds {
            self.value = array[leftBounds]
        } else {
            let middle = (leftBounds + rightBounds) / 2
            self.leftChild = SegmentTree(array: array, leftBounds: leftBounds, rightBounds: middle, function: function)
            self.rightChild = SegmentTree(array: array, leftBounds: middle + 1, rightBounds: rightBounds, function: function)
            self.value = function(leftChild!.value, rightChild!.value)
        }
    }
    
    convenience init(array: [T], function: @escaping (T, T) -> T) {
        self.init(array: array, leftBounds: 0, rightBounds: array.count - 1, function: function)
    }
    
    func query(left: Int, right: Int) -> T {
        if self.leftBounds == left, self.rightBounds == right { return value }
        
        guard let leftChild = leftChild,
              let rightChild = rightChild else { fatalError() }
        
        if leftChild.rightBounds < left {
            return rightChild.query(left: left, right: right)
        } else if rightChild.leftBounds > right {
            return leftChild.query(left: left, right: right)
        } else {
            let leftValue = leftChild.query(left: left, right: leftChild.rightBounds)
            let rightValue = rightChild.query(left: rightChild.leftBounds, right: right)
            
            return function(leftValue, rightValue)
        }
    }
    
    func replaceItem(index: Int, item: T) {
        if leftBounds == rightBounds { 
            value = item
        } else if let leftChild = leftChild, let rightChild = rightChild {
            if leftChild.rightBounds >= index {
                leftChild.replaceItem(index: index, item: item)
            } else {
                rightChild.replaceItem(index: index, item: item)
            }
            
            value = function(leftChild.value, rightChild.value)
        }
    }
}

let infos = readLine()!.split(separator: " ").map { Int($0)! }
let n = infos[0]
let changedNumber = infos[1]
let answerNumber = infos[2]

var arr: [Int] = []

for _ in 0..<n{
    let val = Int(readLine()!)!
    
    arr.append(val)
}

let segmentTree = SegmentTree<Int>(array: arr, function: +)

for _ in 0..<(changedNumber + answerNumber) {
    let infos = readLine()!.split(separator: " ").map { Int($0)! }
    
    if infos[0] == 1 {
        segmentTree.replaceItem(index: infos[1] - 1, item: infos[2])
    } else if infos[0] == 2 {
        print(segmentTree.query(left: infos[1] - 1, right: infos[2] - 1))
    }
}

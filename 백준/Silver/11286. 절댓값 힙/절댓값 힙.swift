import Foundation

struct Heap<T: Comparable> {
    
    private var nodes = [T]()
    
    private var orderCriteria: (T, T) -> Bool
    
    public init(sort: @escaping (T, T) -> Bool) {
        self.orderCriteria = sort
    }
    
    public init(array: [T], sort: @escaping (T, T) -> Bool) {
        self.orderCriteria = sort
        configureHeap(from: array)
    }
    
    public var count: Int {
        return nodes.count
    }
    
    public func peek() -> T? {
        return nodes.first
    }
    
    public mutating func insert(_ value: T) {
        nodes.append(value)
        shiftUp(nodes.count - 1)
    }
    
    public mutating func pop() -> T? {
        guard !nodes.isEmpty else { return nil }
        
        if nodes.count == 1 {
            return nodes.removeLast()
        } else {
            let value = nodes[0]
            nodes[0] = nodes.removeLast()
            shiftDown(0)
            return value
        }
    }
    
    public mutating func remove(at index: Int) -> T? {
        guard index < nodes.count else { return nil }
        
        let lastIndex = nodes.count-1
        if index != lastIndex {
            nodes.swapAt(index, lastIndex)
            shiftDown(from: index, until: lastIndex)
            shiftUp(index)
        }
        
        return nodes.removeLast()
    }
    
    private mutating func configureHeap(from array: [T]) {
        nodes = array
        
        for i in stride(from: nodes.count/2 - 1, through: 0, by: -1) {
            shiftDown(i)
        }
    }
    
    private func parentIndex(ofIndex i: Int) -> Int {
        return (i - 1) / 2
    }
    
    private func leftChildIndex(ofIndex i: Int) -> Int {
        return 2*i + 1
    }
    
    private func rightChildIndex(ofIndex i: Int) -> Int {
        return 2*i + 2
    }
    
    private mutating func shiftUp(_ index: Int) {
        var childIndex = index
        let child = nodes[childIndex]
        var parentIndex = self.parentIndex(ofIndex: index)
        
        while childIndex > 0 && orderCriteria(child, nodes[parentIndex]) {
            nodes[childIndex] = nodes[parentIndex]
            childIndex = parentIndex
            parentIndex = self.parentIndex(ofIndex: childIndex)
        }
        
        nodes[childIndex] = child
    }
    
    private mutating func shiftDown(from index: Int, until endIndex: Int) {
        let leftChildIndex = self.leftChildIndex(ofIndex: index)
        let rightChildIndex = leftChildIndex + 1
        
        var first = index
        if leftChildIndex < endIndex && orderCriteria(nodes[leftChildIndex], nodes[first]) {
            first = leftChildIndex
        }
        if rightChildIndex < endIndex && orderCriteria(nodes[rightChildIndex], nodes[first]) {
            first = rightChildIndex
        }
        if first == index { return }
        
        nodes.swapAt(index, first)
        shiftDown(from: first, until: endIndex)
    }
    
    private mutating func shiftDown(_ index: Int) {
        shiftDown(from: index, until: nodes.count)
    }
    
}

final class Node: Comparable {
    static func == (lhs: Node, rhs: Node) -> Bool {
        return abs(lhs.value) == abs(rhs.value)
    }
    
    static func < (lhs: Node, rhs: Node) -> Bool {
        if abs(lhs.value) == abs(rhs.value) {
            return lhs.value < rhs.value
        }
        return abs(lhs.value) < abs(rhs.value)
    }
    
    let value: Int
    
    init(value: Int) {
        self.value = value
    }
}

let n = Int(readLine()!)!
var minHeap = Heap<Node>(sort: <)

for _ in 0..<n {
    let val = Int(readLine()!)!
    
    if val == 0 {
        guard let poppedValue = minHeap.pop()?.value else {
            print(0)
            continue
        }
        print(poppedValue)
    } else {
        let node = Node(value: val)
        minHeap.insert(node)
    }
}
import Foundation

struct Heap<T: Comparable> {
    
    var nodes = [T]()
    
    private var orderCriteria: (T, T) -> Bool
    
    init(sort: @escaping (T, T) -> Bool) {
        self.orderCriteria = sort
    }
    
    init(array: [T], sort: @escaping (T, T) -> Bool) {
        self.orderCriteria = sort
        configureHeap(from: array)
    }
    
    var count: Int {
        return nodes.count
    }
    
    var isEmpty: Bool {
        return nodes.isEmpty
    }
    
    func peek() -> T? {
        return nodes.first
    }
    
    mutating func insert(_ value: T) {
        nodes.append(value)
        shiftUp(nodes.count - 1)
    }
    
    mutating func pop() -> T? {
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
    
    mutating func remove(at index: Int) -> T? {
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

struct NodeInfo: Comparable {
    static func < (lhs: NodeInfo, rhs: NodeInfo) -> Bool {
        return lhs.weight < rhs.weight
    }
    
    let node: Int
    let weight: Int
    
    init(node: Int, weight: Int = 0) {
        self.node = node
        self.weight = weight
    }
}

func dijkstra(graph: [Int: [Int: Int]], start: Int) -> [Int: Int] {
    var distances: [Int: Int] = [:]
    var maxHeap = Heap<NodeInfo>(sort: <)
    
    for key in graph.keys {
        let value = key == start ? 0: Int.max
        distances.updateValue(value, forKey: key)
    }
    
    maxHeap.insert(NodeInfo(node: start))
    
    while !maxHeap.isEmpty {
        let poppedNode = maxHeap.pop()!
        
        if distances[poppedNode.node]! < poppedNode.weight { continue }
        
        for (node, weight) in graph[poppedNode.node]! {
            let distance = weight + poppedNode.weight
            if distance < distances[node]! {
                distances[node] = distance
                maxHeap.insert(NodeInfo(node: node, weight: distance))
            }
        }
    }
    
    return distances
}

func solution1916() {
    let cityNum = Int(readLine()!)!
    let busNum = Int(readLine()!)!
    
    var graph: [Int: [Int: Int]] = [:]
    
    for city in 1...cityNum {
        graph[city] = [:]
    }
    
    for _ in 0..<busNum {
        let info = readLine()!.split(separator: " ").map { Int(String($0))! }
        
        if graph[info[0]]![info[1]] ?? Int.max > info[2] {
            graph[info[0]]?.updateValue(info[2], forKey: info[1])
        }
    }
    
    let info = readLine()!.split(separator: " ").map { Int(String($0))! }
    let startPoint = info[0]
    let endPoint = info[1]
    
    let distances = dijkstra(graph: graph, start: startPoint)
    
    print(distances[endPoint]!)
}

solution1916()
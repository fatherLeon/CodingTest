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
    
    var isEmpty: Bool {
        return nodes.isEmpty
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

struct NodePriority: Comparable {
    static func < (lhs: NodePriority, rhs: NodePriority) -> Bool {
        lhs.priority < rhs.priority
    }
    var node: String = ""
    var priority: Int = 0
}

func dijkstra(graph: [String: [String: Int]], start: String) ->  [String: Int] {
    var distances: [String: Int] = [:]
    var priorityQueue = Heap<NodePriority>(sort: <)
    
    priorityQueue.insert(NodePriority(node: start, priority: 0))
    
    for key in graph.keys {
        let value = key == start ? 0 : Int.max
        distances.updateValue(value, forKey: key)
    }
    
    while !priorityQueue.isEmpty {
        guard let popped = priorityQueue.pop() else { break }
        
        if distances[popped.node]! < popped.priority {
            continue
        }
        
        for (node, priority) in graph[popped.node]! {
            let distance = priority + popped.priority
            if distance < distances[node]! {
                distances[node] = distance
                priorityQueue.insert(NodePriority.init(node: node, priority: distance))
            }
        }
    }
    return distances
}

let graphInfos = readLine()!.split(separator: " ").map { Int($0)! }
let vertexNum = graphInfos[0]
let edgeNum = graphInfos[1]

let start = readLine()!

var graph: [String: [String: Int]] = [:]

for v in 1...vertexNum {
    graph[String(v)] = [:]
}

for _ in 0..<edgeNum {
    let info = readLine()!.split(separator: " ").map { Int($0)! }
    
    if graph[String(info[0])]![String(info[1])] ?? Int.max > info[2] {
        graph[String(info[0])]![String(info[1])] = info[2]
    }
}

let answer = dijkstra(graph: graph, start: start)

for i in 1...vertexNum {
    let a = answer[String(i)]!
    
    if a == Int.max {
        print("INF")
    } else {
        print(a)
    }
}

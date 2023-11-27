import Foundation

struct Queue<T> {
    private var enqueueStack: [T] = []
    private var dequeueStack: [T] = []
    
    var isEmpty: Bool {
        return enqueueStack.isEmpty && dequeueStack.isEmpty
    }
    
    mutating func enqueue(_ value: T) {
        enqueueStack.append(value)
    }
    
    mutating func dequeue() -> T? {
        if dequeueStack.isEmpty {
            dequeueStack = enqueueStack.reversed()
            enqueueStack.removeAll()
        }
        
        return dequeueStack.popLast()
    }
}

func bfs(graph: [[Int]], start: Int) -> Int {
    var queue = Queue<(value: Int, level: Int)>()
    var visitedNode: [(value: Int, level: Int)] = []
    
    queue.enqueue((start, 0))
    visitedNode.append((start, 0))
    
    while !queue.isEmpty {
        let node = queue.dequeue()!
        
        graph[node.value].forEach { val in
            if !visitedNode.contains(where: { $0.value == val }) {
                queue.enqueue((val, node.level + 1))
                visitedNode.append((val, node.level + 1))
            }
        }
    }
    
    return visitedNode.max { $0.level < $1.level }!.level
}

func solution2660() {
    let n = Int(readLine()!)!
    var graph: [[Int]] = Array(repeating: [], count: n + 1)
    
    while true {
        let infos = readLine()!.split(separator: " ").map { Int($0)! }
        
        if infos[0] == -1 && infos[1] == -1 { break }
        
        graph[infos[0]].append(infos[1])
        graph[infos[1]].append(infos[0])
    }
    
    var answer: [Int] = [Int.max]
    
    for x in 1...graph.count-1 {
        answer.append(bfs(graph: graph, start: x))
    }
    
    let minValue = answer.min()!
    let count = answer.filter { $0 == minValue }.count
    
    print(minValue, terminator: " ")
    print(count)
    
    for x in 1...answer.count-1 {
        if minValue == answer[x] {
            print(x, terminator: " ")
        }
    }
}

solution2660()
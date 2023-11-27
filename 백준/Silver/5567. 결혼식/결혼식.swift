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
    
    return visitedNode.filter { $0.level <= 2 }.count - 1
}

func solution5567() {
    let peopleNum = Int(readLine()!)!
    let n = Int(readLine()!)!
    
    var graph: [[Int]] = Array(repeating: [], count: peopleNum + 1)
    
    for _ in 0..<n {
        let infos = readLine()!.split(separator: " ").map { Int($0)! }
        
        graph[infos[0]].append(infos[1])
        graph[infos[1]].append(infos[0])
    }
    
    print(bfs(graph: graph, start: 1))
}

solution5567()

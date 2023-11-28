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


func bfs(graph: [[Int]], start: Int, visitedNode: [Int] = []) -> (visitedNode: [Int], answer: Int) {
    var queue = Queue<Int>()
    var visitedNode = visitedNode
    var answer = 0
    
    queue.enqueue(start)
    visitedNode.append(start)
    
    while !queue.isEmpty {
        let node = queue.dequeue()!
        
        graph[node].forEach { val in
            if !visitedNode.contains(val) {
                queue.enqueue(val)
                visitedNode.append(val)
                answer += 1
            }
        }
    }
    
    return (visitedNode, answer)
}

func solution2617() {
    let infos = readLine()!.split(separator: " ").map { Int($0)! }
    let (ballNum, num) = (infos[0], infos[1])
    let middleValue = (infos[0] + 1) / 2
    
    var heavyGraph: [[Int]] = Array(repeating: [], count: ballNum + 1)
    var lightGraph: [[Int]] = Array(repeating: [], count: ballNum + 1)
    var answer = 0
    
    for _ in 0..<num {
        let balls = readLine()!.split(separator: " ").map { Int($0)! }
        heavyGraph[balls[1]].append(balls[0])
        lightGraph[balls[0]].append(balls[1])
    }
    
    for x in 1...ballNum {
        let heavyInfo = bfs(graph: heavyGraph, start: x)
        let lightInfo = bfs(graph: lightGraph, start: x, visitedNode: heavyInfo.visitedNode)
        
        if heavyInfo.answer >= middleValue {
            answer += 1
        }
        
        if lightInfo.answer >= middleValue {
            answer += 1
        }
    }
    
    print(answer)
}

solution2617()

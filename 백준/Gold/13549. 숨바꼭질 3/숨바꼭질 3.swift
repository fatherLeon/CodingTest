import Foundation

extension Int {
    var nextStep: [Int] {
        return [self + 1, self - 1, self * 2]
    }
}

struct Queue<T> {
    private var enqueueStack: [T] = []
    private var dequeueStack: [T] = []
    
    var isEmpty: Bool {
        return enqueueStack.isEmpty && dequeueStack.isEmpty
    }
    
    var count: Int {
        return enqueueStack.count + dequeueStack.count
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


func solution13549() {
    let info = readLine()!.split(separator: " ").map { Int(String($0))! }
    let startPoint = info[0]
    let endPoint = info[1]
    
    var graph: [Int] = Array(repeating: 0, count: 100001)
    var isVisited: [Bool] = Array(repeating: false, count: 100001)
    var queue = Queue<Int>()
    
    queue.enqueue(startPoint)
    isVisited[startPoint] = true
    graph[startPoint] = 1
    
    while !queue.isEmpty {
        let nowX = queue.dequeue()!
        
        if nowX == endPoint { break }
        for x in nowX.nextStep {
            if x < 0 || x >= graph.count { continue }
            
            let value = x == nowX * 2 ? graph[nowX]: graph[nowX] + 1
            
            if isVisited[x] == true && graph[x] != 0 && graph[x] < value {
                continue
            }
            
            isVisited[x] = true
            queue.enqueue(x)
            graph[x] = value
        }
    }
    print(graph[endPoint] - 1)
}

solution13549()

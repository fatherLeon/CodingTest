import Foundation

struct Queue<T> {
    var enqueueStack: [T] = []
    var dequeueStack: [T] = []
    
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

let graphInfos = readLine()!.split(separator: " ").map { Int($0)! }
let maxX = graphInfos[0]
let maxY = graphInfos[1]

let dxs = [0, 0, -1, 1]
let dys = [-1, 1, 0, 0]
var graph: [[Int]] = []
var queue = Queue<(x: Int, y: Int)>()
var isVisited: [[Bool]] = Array(repeating: Array(repeating: false, count: maxY), count: maxX)
var answer: [[Int]] = Array(repeating: Array(repeating: -1, count: maxY), count: maxX)
var startCoordinate: (x: Int, y: Int) = (0, 0)

for _ in 0..<maxX {
    let arr = readLine()!.split(separator: " ").map { Int($0)! }
    
    graph.append(arr)
}

for x in 0..<maxX {
    for y in 0..<maxY {
        if graph[x][y] == 2 {
            startCoordinate.x = x
            startCoordinate.y = y
        }
        
        if graph[x][y] == 0 {
            answer[x][y] = 0
        }
    }
}

queue.enqueue(startCoordinate)
isVisited[startCoordinate.x][startCoordinate.y] = true
answer[startCoordinate.x][startCoordinate.y] = 0

while !queue.isEmpty {
    let coordinate = queue.dequeue()!
    
    for (dx, dy) in zip(dxs, dys) {
        let x = coordinate.x + dx
        let y = coordinate.y + dy
        
        if x >= 0 && x < maxX && y >= 0 && y < maxY &&
            !isVisited[x][y] && graph[x][y] == 1 {
            queue.enqueue((x, y))
            isVisited[x][y] = true
            answer[x][y] = answer[coordinate.x][coordinate.y] + 1
        }
    }
}

for x in answer {
    for y in x {
        print(y, terminator: " ")
    }
    print()
}

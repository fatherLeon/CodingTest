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

func bfs(coordinate: (x: Int, y: Int)) -> Int {
    let dxs = [0, 0, -1, 1]
    let dys = [-1, 1, 0, 0]
    
    var answer = 1
    var queue = Queue<(x: Int, y: Int)>()
    
    queue.enqueue((coordinate.x, coordinate.y))
    graph[coordinate.x][coordinate.y] = -1
    
    while !queue.isEmpty {
        let coordinate = queue.dequeue()!
        
        for (dx, dy) in zip(dxs, dys) {
            let x = coordinate.x + dx
            let y = coordinate.y + dy
            
            if x >= 0 && x < n && y >= 0 && y < n && graph[x][y] == 1 {
                answer += 1
                graph[x][y] = -1
                queue.enqueue((x, y))
            }
        }
    }
    
    return answer
}

let n = Int(readLine()!)!
var blockNumAnswer = 0
var houseNumAnswer: [Int] = []
var graph: [[Int]] = []

for _ in 0..<n {
    let inputs = Array(readLine()!).map { Int(String($0))! }
    
    graph.append(inputs)
}

for x in 0..<n {
    for y in 0..<n {
        if graph[x][y] == 1 {
            blockNumAnswer += 1
            let houseNum = bfs(coordinate: (x, y))
            houseNumAnswer.append(houseNum)
        }
    }
}

print(blockNumAnswer)
houseNumAnswer.sorted(by: <)
    .forEach { val in
        print(val)
    }

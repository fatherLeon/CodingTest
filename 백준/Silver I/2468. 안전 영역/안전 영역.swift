import Foundation

struct Queue<T> {
    var enqueueStack: [T] = []
    var dequeueStack: [T] = []
    
    var isCount: Int {
        return enqueueStack.count + dequeueStack.count
    }
    
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

func bfs(n: Int, area: [[Int]]) -> Int {
    var isVisited: [[Bool]] = Array(repeating: Array(repeating: false, count: area[0].count), count: area.count)
    var graph: [[Int]] = Array(repeating: Array(repeating: 0, count: area[0].count), count: area.count
    )
    var answer: [[Int]] = Array(repeating: Array(repeating: 0, count: area[0].count), count: area.count
    )
    
    for x in 0..<area.count {
        for y in 0..<area[0].count {
            if area[x][y] > n {
                graph[x][y] = 1
            }
        }
    }
    
    let dxs = [0, 0, -1, 1]
    let dys = [1, -1, 0, 0]
    var flag = 1
    
    for x in 0..<graph.count {
        for y in 0..<graph[0].count {
            var queue: Queue<(Int, Int)> = Queue()
            
            if graph[x][y] != 0 && isVisited[x][y] == false && answer[x][y] == 0 {
                queue.enqueue((x, y))
                isVisited[x][y] = true
                answer[x][y] = flag
                flag += 1
            }
            
            while !queue.isEmpty {
                let coordinate = queue.dequeue()!
                
                for (dx, dy) in zip(dxs, dys) {
                    let newX = coordinate.0 + dx
                    let newY = coordinate.1 + dy
                    
                    if newX >= 0 && newX < graph.count && newY >= 0 && newY < graph.count && graph[newX][newY] != 0 && isVisited[newX][newY] == false && answer[newX][newY] == 0 {
                        answer[newX][newY] = flag
                        queue.enqueue((newX, newY))
                        isVisited[newX][newY] = true
                    }
                }
            }
        }
    }
    
    return flag - 1
}

func solution2468() {
    let n = Int(readLine()!)!
    var graph: [[Int]] = []
    var maxValue = 0
    var answer = 0
    
    for _ in 0..<n {
        let temp = readLine()!.split(separator: " ").map { Int($0)! }
        
        graph.append(temp)
        
        if maxValue < temp.max()! {
            maxValue = temp.max()!
        }
    }
    
    for val in 0..<maxValue {
        let value = bfs(n: val, area: graph)
        
        if answer < value {
            answer = value
        }
    }
    
    print(answer)
}

solution2468()

import Foundation

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


func bfs(graph: [[Int]]) -> Int {
    let dxs = [0, 0, -1, 1]
    let dys = [-1, 1, 0, 0]
    
    var queue = Queue<(x: Int, y: Int)>()
    var answer = Array(repeating: Array(repeating: 0, count: graph[0].count), count: graph.count)
    var isVisited = Array(repeating: Array(repeating: false, count: graph[0].count), count: graph.count)
    var flag = 1
    
    for x in 0..<graph.count {
        for y in 0..<graph[0].count {
            if graph[x][y] != 0 && isVisited[x][y] == false {
                queue.enqueue((x, y))
                isVisited[x][y] = true
                answer[x][y] = flag
                
                while !queue.isEmpty {
                    let coordinate = queue.dequeue()!
                    
                    for (dx, dy) in zip(dxs, dys) {
                        let x = coordinate.x + dx
                        let y = coordinate.y + dy
                        
                        if x < 0 || x >= graph.count || y < 0 || y >= graph[0].count { continue }
                        
                        if isVisited[x][y] == false && graph[x][y] != 0 {
                            queue.enqueue((x, y))
                            answer[x][y] = flag
                            isVisited[x][y] = true
                        }
                    }
                }
                
                flag += 1
            }
        }
    }
    
    return flag - 1
}

func solution2573() {
    let info = readLine()!.split(separator: " ").map { Int($0)! }
    let N = info[0]
    var graph: [[Int]] = []
    
    for _ in 0..<N {
        let arr = readLine()!.split(separator: " ").map { Int($0)! }
        
        graph.append(arr)
    }
    
    var nowIcebergCount = 0
    var count = 0
    
    while nowIcebergCount < 2 {
        nowIcebergCount = bfs(graph: graph)
        
        if nowIcebergCount == 0 {
            count = 1
            break
        }
        
        var temp = graph
        
        for x in 0..<graph.count {
            for y in 0..<graph[0].count {
                if graph[x][y] != 0 {
                    let dxs = [0, 0, -1, 1]
                    let dys = [-1, 1, 0, 0]
                    
                    for (dx, dy) in zip(dxs, dys) {
                        let newX = x + dx
                        let newY = y + dy
                        
                        if newX < 0 || newX >= graph.count || newY < 0 || newY >= graph[0].count { continue }
                        
                        temp[x][y] = graph[newX][newY] == 0 ? max(temp[x][y] - 1, 0) : temp[x][y]
                    }
                }
            }
        }
        
        graph = temp
        count += 1
    }
    print(count - 1)
}

solution2573()

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

func bfsFire(graph: [[Int]]) -> [[Int]] {
    let dxs = [0, 0, -1, 1]
    let dys = [-1, 1, 0, 0]
    var queue = Queue<(x: Int, y: Int)>()
    var answer = Array(repeating: Array(repeating: 0, count: graph[0].count), count: graph.count)
    var isVisited = Array(repeating: Array(repeating: false, count: graph[0].count), count: graph.count)
    
    for x in 0..<graph.count {
        for y in 0..<graph[0].count {
            if graph[x][y] == -1 {
                queue.enqueue((x, y))
                answer[x][y] = -1
                isVisited[x][y] = true
            }
        }
    }
    
    while !queue.isEmpty {
        let coordinate = queue.dequeue()!
        
        for (dx, dy) in zip(dxs, dys) {
            let x = coordinate.x + dx
            let y = coordinate.y + dy
            
            if x < 0 || x >= graph.count || y < 0 || y >= graph[0].count || graph[x][y] == Int.min { continue }
            
            if isVisited[x][y] == false {
                queue.enqueue((x, y))
                answer[x][y] = answer[coordinate.x][coordinate.y] - 1
                isVisited[x][y] = true
            }
        }
    }
    
    return answer
}

func bfs(graph: [[Int]], fireGraph: [[Int]], startCoordinate: (x: Int, y: Int)) -> Int {
    let dxs = [0, 0, -1, 1]
    let dys = [-1, 1, 0, 0]
    
    var queue = Queue<(x: Int, y: Int)>()
    var answer: [[Int]] = Array(repeating: Array(repeating: 0, count: graph[0].count), count: graph.count)
    var isVisited: [[Bool]] = Array(repeating: Array(repeating: false, count: graph[0].count), count: graph.count)
    
    queue.enqueue(startCoordinate)
    isVisited[startCoordinate.x][startCoordinate.y] = true
    answer[startCoordinate.x][startCoordinate.y] = 1
    
    while !queue.isEmpty {
        let coordinate = queue.dequeue()!
        
        if coordinate.x == 0 || coordinate.x == (graph.count - 1) || coordinate.y == 0 || coordinate.y == (graph[0].count - 1) {
            return answer[coordinate.x][coordinate.y]
        }
        
        for (dx, dy) in zip(dxs, dys) {
            let x = coordinate.x + dx
            let y = coordinate.y + dy
            
            if x < 0 || x >= graph.count || y < 0 || y >= graph[0].count || graph[x][y] == Int.min { continue }
            
            if isVisited[x][y] == false {
                isVisited[x][y] = true
                
                if answer[coordinate.x][coordinate.y] + 1 < abs(fireGraph[x][y]) || fireGraph[x][y] == 0 {
                    queue.enqueue((x, y))
                    answer[x][y] = answer[coordinate.x][coordinate.y] + 1
                }
            }
        }
    }
    
    return 0
}

func solution4179() {
    let miroInfos = readLine()!.split(separator: " ").map { Int($0)! }
    let (R, C) = (miroInfos[0], miroInfos[1])
    
    var graph: [[Int]] = []
    var jihoonCoordinate = (x: 0, y: 0)
    
    for x in 0..<R {
        let arr: [Int] = Array(readLine()!).map { val in
            switch val {
            case "J":
                return 1
            case "F":
                return -1
            case "#":
                return Int.min
            default:
                return 0
            }
        }
        
        if arr.contains(1) {
            let y = arr.firstIndex(of: 1)!
            
            jihoonCoordinate = (x, y)
        }
        
        graph.append(arr)
    }
    
    let fireGraph = bfsFire(graph: graph)
    let answer = bfs(graph: graph, fireGraph: fireGraph, startCoordinate: jihoonCoordinate)
    
    if answer == 0 {
        print("IMPOSSIBLE")
    } else {
        print(answer)
    }
}

solution4179()

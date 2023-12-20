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

func fireBFS(graph: [[String]]) -> [[Int]] {
    let dxs = [0, 0, -1, 1]
    let dys = [-1, 1, 0, 0]
    var queue: Queue<(x: Int, y: Int)> = Queue()
    var isVisited: [[Bool]] = Array(repeating: Array(repeating: false, count: graph[0].count), count: graph.count)
    var answer: [[Int]] = Array(repeating: Array(repeating: 0, count: graph[0].count), count: graph.count)
    
    for x in 0..<graph.count {
        for y in 0..<graph[0].count {
            if graph[x][y] == "*" {
                queue.enqueue((x, y))
                isVisited[x][y] = true
                answer[x][y] = 1
            }
        }
    }
    
    while !queue.isEmpty {
        let coordinate = queue.dequeue()!
        
        for (dx, dy) in zip(dxs, dys) {
            let x = coordinate.x + dx
            let y = coordinate.y + dy
            
            if x < 0 || x >= graph.count || y < 0 || y >= graph[0].count || graph[x][y] == "#" || isVisited[x][y] == true { continue }
            
            answer[x][y] = answer[coordinate.x][coordinate.y] + 1
            isVisited[x][y] = true
            queue.enqueue((x, y))
        }
    }
    
    return answer
}

func BFS(graph: [[String]], fireGraph: [[Int]], startCoordinate: (x: Int, y: Int)) -> Int {
    let dxs = [0, 0, -1, 1]
    let dys = [-1, 1, 0, 0]
    var queue: Queue<(x: Int, y: Int)> = Queue()
    var isVisited: [[Bool]] = Array(repeating: Array(repeating: false, count: graph[0].count), count: graph.count)
    var answer: [[Int]] = Array(repeating: Array(repeating: 0, count: graph[0].count), count: graph.count)
    
    answer[startCoordinate.x][startCoordinate.y] = 1
    isVisited[startCoordinate.x][startCoordinate.y] = true
    queue.enqueue((startCoordinate.x, startCoordinate.y))
    
    while !queue.isEmpty {
        let coordinate = queue.dequeue()!
        
        if coordinate.x == 0 || coordinate.x == (graph.count - 1) || coordinate.y == 0 || coordinate.y == (graph[0].count - 1) {
            return answer[coordinate.x][coordinate.y]
        }
        
        for (dx, dy) in zip(dxs, dys) {
            let x = coordinate.x + dx
            let y = coordinate.y + dy
            
            if x < 0 || x >= graph.count || y < 0 || y >= graph[0].count || graph[x][y] != "." || isVisited[x][y] { continue }
            
            if fireGraph[x][y] == 0 || fireGraph[x][y] > answer[coordinate.x][coordinate.y] + 1 {
                answer[x][y] = answer[coordinate.x][coordinate.y] + 1
                isVisited[x][y] = true
                queue.enqueue((x, y))
            }
        }
    }
    
    return 0
}

func solution5427() {
    let testCase = Int(readLine()!)!
    
    for _ in 0..<testCase {
        let graphInfo = readLine()!.split(separator: " ").map { Int($0)! }
        let _ = graphInfo[0], h = graphInfo[1]
        
        var graph: [[String]] = []
        var startCoordinate = (x: 0, y: 0)
        
        for x in 0..<h {
            let info = Array(readLine()!).map { String($0) }
            
            graph.append(info)
            
            if info.contains("@") {
                let y = info.firstIndex(of: "@")!
                startCoordinate = (x, y)
            }
        }
        
        let fireGraph = fireBFS(graph: graph)
        let answer = BFS(graph: graph, fireGraph: fireGraph, startCoordinate: startCoordinate)
        
        if answer == 0 {
            print("IMPOSSIBLE")
        } else {
            print(answer)
        }
    }
}

solution5427()

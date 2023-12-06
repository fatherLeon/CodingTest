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


func bfs(graph: [[String]]) -> Int {
    let dxs = [0, 0, -1, 1]
    let dys = [-1, 1, 0, 0]
    var answer: [[Int]] = Array(repeating: Array(repeating: 0, count: graph.count), count: graph.count)
    var isVisited: [[Bool]] = Array(repeating: Array(repeating: false, count: graph.count), count: graph.count)
    var queue = Queue<(Int, Int)>()
    
    var flag = 1
    
    for x in 0..<graph.count {
        for y in 0..<graph.count {
            if isVisited[x][y] == false {
                let value = graph[x][y]
                
                queue.enqueue((x, y))
                answer[x][y] = flag
                isVisited[x][y] = true
                
                while !queue.isEmpty {
                    let (x, y) = queue.dequeue()!
                    
                    for (dx, dy) in zip(dxs, dys) {
                        let newX = x + dx
                        let newY = y + dy
                        
                        if newX < 0 || newX >= graph.count || newY < 0 || newY >= graph.count {
                            continue
                        } else {
                            if isVisited[newX][newY] == false && graph[newX][newY] == value {
                                queue.enqueue((newX, newY))
                                answer[newX][newY] = flag
                                isVisited[newX][newY] = true
                            }
                        }
                    }
                }
                flag += 1
            }
        }
    }
    
    return flag
}

func bfsError(graph: [[String]]) -> Int {
    let dxs = [0, 0, -1, 1]
    let dys = [-1, 1, 0, 0]
    var answer: [[Int]] = Array(repeating: Array(repeating: 0, count: graph.count), count: graph.count)
    var isVisited: [[Bool]] = Array(repeating: Array(repeating: false, count: graph.count), count: graph.count)
    var queue = Queue<(Int, Int)>()
    
    var flag = 1
    
    for x in 0..<graph.count {
        for y in 0..<graph.count {
            if isVisited[x][y] == false {
                let value = graph[x][y]
                
                queue.enqueue((x, y))
                answer[x][y] = flag
                isVisited[x][y] = true
                
                while !queue.isEmpty {
                    let (x, y) = queue.dequeue()!
                    
                    for (dx, dy) in zip(dxs, dys) {
                        let newX = x + dx
                        let newY = y + dy
                        
                        if newX < 0 || newX >= graph.count || newY < 0 || newY >= graph.count {
                            continue
                        } else {
                            if value == "R" || value == "G" {
                                if isVisited[newX][newY] == false && (graph[newX][newY] == "R" || graph[newX][newY] == "G") {
                                    queue.enqueue((newX, newY))
                                    answer[newX][newY] = flag
                                    isVisited[newX][newY] = true
                                }
                            } else {
                                if isVisited[newX][newY] == false && graph[newX][newY] == "B" {
                                    queue.enqueue((newX, newY))
                                    answer[newX][newY] = flag
                                    isVisited[newX][newY] = true
                                }
                            }
                        }
                    }
                }
                flag += 1
            }
        }
    }
    
    return flag
}

func solution10026() {
    let n = Int(readLine()!)!
    var graph: [[String]] = []
    
    for _ in 0..<n {
        let arr = Array(readLine()!).map { String($0) }
        
        graph.append(arr)
    }
    
    print(bfs(graph: graph) - 1, terminator: " ")
    print(bfsError(graph: graph) - 1)
}

solution10026()

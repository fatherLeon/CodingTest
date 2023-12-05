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

func solution1012() {
    let testCase = Int(readLine()!)!
    
    for _ in 0..<testCase {
        let infos = readLine()!.split(separator: " ").map { Int($0)! }
        let (m, n, k) = (infos[0], infos[1], infos[2])
        
        var answer = 0
        var graph = Array(repeating: Array(repeating: 0, count: m), count: n)
        
        for _ in 0..<k {
            let coordinate = readLine()!.split(separator: " ").map { Int($0)! }
            
            graph[coordinate[1]][coordinate[0]] = 1
        }
        
        var queue = Queue<(x: Int, y: Int)>()
        
        for x in 0..<n {
            for y in 0..<m {
                if graph[x][y] == 1 {
                    queue.enqueue((x, y))
                    graph[x][y] = 0
                    
                    while !queue.isEmpty {
                        let (x, y) = queue.dequeue()!
                        let dxs = [0, 0, -1, 1]
                        let dys = [-1, 1, 0, 0]
                        
                        for (dx, dy) in zip(dxs, dys) {
                            let newX = x + dx
                            let newY = y + dy
                            
                            if newX < 0 || newX >= n || newY < 0 || newY >= m {
                                continue
                            } else {
                                if graph[newX][newY] != 0 {
                                    queue.enqueue((newX, newY))
                                    graph[newX][newY] = 0
                                }
                            }
                        }
                    }
                    answer += 1
                }
            }
        }
        print(answer)
    }
}

solution1012()

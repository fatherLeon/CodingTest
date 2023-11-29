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


func bfs(graph: [[[Int]]], boxInfos: (x: Int, y: Int, z: Int)) {
    let dxs = [-1, 1, 0, 0, 0, 0]
    let dys = [0, 0, -1, 1, 0, 0]
    let dzs = [0, 0, 0, 0, 1, -1]
    
    var queue = Queue<(x: Int, y: Int, z: Int)>()
    var answer: [[[Int]]] = Array(repeating: Array(repeating: Array(repeating: 0, count: boxInfos.x), count: boxInfos.y), count: boxInfos.z)
    
    for z in 0..<boxInfos.z {
        for y in 0..<boxInfos.y {
            for x in 0..<boxInfos.x {
                if graph[z][y][x] == 1 {
                    queue.enqueue((x, y, z))
                    answer[z][y][x] = 1
                } else if graph[z][y][x] == -1 {
                    answer[z][y][x] = -1
                }
            }
        }
    }
    
    while !queue.isEmpty {
        let coordinate = queue.dequeue()!
        
        for (dx, (dy, dz)) in zip(dxs, zip(dys, dzs)) {
            let x = coordinate.x + dx
            let y = coordinate.y + dy
            let z = coordinate.z + dz
            
            if x < 0 || x >= boxInfos.x || y < 0 || y >= boxInfos.y || z < 0 || z >= boxInfos.z {
                continue
            } else {
                if graph[z][y][x] == 0 && answer[z][y][x] == 0 {
                    queue.enqueue((x, y, z))
                    answer[z][y][x] = answer[coordinate.z][coordinate.y][coordinate.x] + 1
                }
            }
        }
    }
    
    let flattenAnswer = answer.flatMap { $0 }.flatMap { $0 }
    
    if flattenAnswer.contains(0) {
        print(-1)
    } else {
        let value = flattenAnswer.max()! - 1
        
        if value < 0 {
            print(0)
        } else {
            print(value)
        }
    }
}

func solution7569() {
    let infos = readLine()!.split(separator: " ").map { Int($0)! }
    let (m, n, h) = (infos[0], infos[1], infos[2])
    
    var graph: [[[Int]]] = []
    
    for x in 0..<h {
        graph.append([])
        for _ in 0..<n {
            let arr = readLine()!.split(separator: " ").map { Int($0)! }
            graph[x].append(arr)
        }
    }
    
    bfs(graph: graph, boxInfos: (m, n, h))
}

solution7569()

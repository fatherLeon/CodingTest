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

func bfs(_ standardCoordinate: (x: Int, y: Int)) -> Int {
    var queue = Queue<(x: Int, y: Int)>()
    var count = 1
    
    let dxs = [0, 0, -1, 1]
    let dys = [-1, 1, 0, 0]
    
    queue.enqueue(standardCoordinate)
    isVisited[standardCoordinate.x][standardCoordinate.y] = true
    
    while !queue.isEmpty {
        let coordinate = queue.dequeue()!
        
        for (dx, dy) in zip(dxs, dys) {
            if coordinate.x + dx >= 0 && coordinate.x + dx < maxX &&
                coordinate.y + dy >= 0 && coordinate.y + dy < maxY {
                
                if !isVisited[coordinate.x + dx][coordinate.y + dy] &&
                    graph[coordinate.x + dx][coordinate.y + dy] == 1 {
                    queue.enqueue((coordinate.x + dx, coordinate.y + dy))
                    isVisited[coordinate.x + dx][coordinate.y + dy] = true
                    answer[coordinate.x + dx][coordinate.y + dy] = answer[coordinate.x][coordinate.y] + 1
                    count += 1
                }
            }
        }
    }
    
    return count
}

let infos = readLine()!.split(separator: " ").map { Int($0)! }
let maxX = infos[0]
let maxY = infos[1]

var numOfPicture = 0
var graph: [[Int]] = []
var isVisited: [[Bool]] = Array(repeating: Array(repeating: false, count: maxY), count: maxX)
var answer: [[Int]] = Array(repeating: Array(repeating: 0, count: maxY), count: maxX)
var areas: [Int] = []

for _ in 0..<maxX {
    let arr = readLine()!.split(separator: " ").map { Int($0)! }
    
    graph.append(arr)
}

for x in 0..<maxX {
    for y in 0..<maxY {
        if !isVisited[x][y] && graph[x][y] == 1 {
            numOfPicture += 1
            answer[x][y] = 1
            let area = bfs((x, y))
            areas.append(area)
        }
    }
}

print(numOfPicture)
print(areas.max() ?? 0)

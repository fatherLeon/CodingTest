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


func solution2583() {
    let info = readLine()!.split(separator: " ").map { Int($0)! }
    
    let maxX = info[0]
    let maxY = info[1]
    let n = info[2]
    
    var arr = Array(repeating: Array(repeating: 0, count: maxY), count: maxX)
    
    for _ in 0..<n {
        let squareInfo = readLine()!.split(separator: " ").map { Int($0)! }
        
        let startCoordinate = (x: squareInfo[0], y: squareInfo[1])
        let endCoordinate = (x: squareInfo[2], y: squareInfo[3])
        
        for y in startCoordinate.x..<endCoordinate.x {
            for x in startCoordinate.y..<endCoordinate.y {
                arr[x][y] = -1
            }
        }
    }
    
    var queue = Queue<(x: Int, y: Int)>()
    var flag = 1
    var answer: [Int] = []
    
    for x in 0..<maxX {
        for y in 0..<maxY {
            if arr[x][y] == 0 {
                var area = 1
                queue.enqueue((x, y))
                arr[x][y] = flag
                
                while !queue.isEmpty {
                    let (x, y) = queue.dequeue()!
                    let dxs = [0, 0, -1, 1]
                    let dys = [-1, 1, 0, 0]
                    
                    for (dx, dy) in zip(dxs, dys) {
                        let newX = x + dx
                        let newY = y + dy
                        
                        if newX < 0 || newX >= maxX || newY < 0 || newY >= maxY {
                            continue
                        } else {
                            if arr[newX][newY] == 0 {
                                queue.enqueue((newX, newY))
                                arr[newX][newY] = flag
                                area += 1
                            }
                        }
                    }
                }
                answer.append(area)
                flag += 1
            }
        }
    }
    
    print(flag - 1)
    
    for area in answer.sorted() {
        print(area, terminator: " ")
    }
}

solution2583()

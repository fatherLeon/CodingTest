struct Queue {
    var enqueueStack: [Int] = []
    var dequeueStack: [Int] = []
    
    var isEmpty: Bool {
        return enqueueStack.isEmpty && dequeueStack.isEmpty
    }
    
    mutating func append(_ value: Int) {
        enqueueStack.append(value)
    }
    
    mutating func append(_ values: [Int]) {
        enqueueStack += values
    }
    
    mutating func pop() -> Int? {
        if self.isEmpty { return nil }
        
        if dequeueStack.isEmpty {
            dequeueStack = enqueueStack.reversed()
            enqueueStack.removeAll()
        }
        
        return dequeueStack.popLast()
    }
}

func dfs(_ index: Int, nodes: [Int]) {
    if visitedNodes.contains(index) { return }
    
    visitedNodes.append(index)
    print(index, terminator: " ")
    
    if let _ = graphs[index].first {
        graphs[index].forEach { index in
            dfs(index, nodes: graphs[index])
        }
    } else {
        return
    }
}

func bfs(_ index: Int) {
    var queue = Queue()
    queue.append(index)
    
    while !queue.isEmpty {
        guard let value = queue.pop() else { break }
        print(value, terminator: " ")
        
        graphs[value].forEach { v in
            if visitedNodes.contains(v) { return }
            
            queue.append(v)
            visitedNodes.append(v)
        }
    }
}

var visitedNodes: [Int] = []
let infos = readLine()!.split(separator: " ").map { Int($0)! }
var graphs: [[Int]] = Array(repeating: Array(), count: infos[0] + 1)

for _ in 1...infos[1] {
    let inputs = readLine()!.split(separator: " ").map { Int($0)! }
    
    graphs[inputs[0]].append(inputs[1])
    graphs[inputs[1]].append(inputs[0])
}

for x in 1...(infos[0]) {
    graphs[x].sort { $0 < $1 }
}

dfs(infos[2], nodes: [])

print()
visitedNodes = [infos[2]]

bfs(infos[2])

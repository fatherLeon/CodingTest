import Foundation

var visitedNodes: [Int] = []

func dfs(_ startedIndex: Int, _ graph: [[Int]], completionHandler: ((Int) -> Bool)) -> Bool {
    visitedNodes.append(startedIndex)
    let result = completionHandler(startedIndex)
    
    if result { return true }
    
    for node in graph[startedIndex] {
        if visitedNodes.contains(node) {
            continue
        }
        
        let result = dfs(node, graph, completionHandler: completionHandler)
        
        if result { return true }
    }
    
    return false
}

let nodeNum = Int(readLine()!)!
var graph: [[Int]] = Array(repeating: Array(), count: nodeNum)
var answer: [[Int]] = []

for n in 0..<nodeNum {
    let graphInfo = readLine()!.split(separator: " ").map { Int($0)! }
    
    for (index, val) in graphInfo.enumerated() {
        if val == 1 {
            graph[n].append(index)
        }
    }
}

for x in 0..<nodeNum {
    var arr: [Int] = []
    
    for y in 0..<nodeNum {
        visitedNodes.removeAll()
        
        let result = dfs(x, graph) { val in
            if graph[val].contains(y) {
                return true
            } else {
                return false
            }
        }
        
        if result {
            arr.append(1)
        } else {
            arr.append(0)
        }
    }
    
    answer.append(arr)
}

for a in answer {
    for y in a {
        print(y, terminator: " ")
    }
    print()
}
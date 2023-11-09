import Foundation

var visitedNodes: [Int] = []

func dfs(_ startedIndex: Int, _ graph: [[Int]]) {
    visitedNodes.append(startedIndex)
    
    graph[startedIndex].forEach { node in
        if visitedNodes.contains(node) {
            return
        }
        
        dfs(node, graph)
    }
}

let infos = readLine()!.split(separator: " ").map { Int($0)! }
let nodeNum = infos[0]
let vertexNum = infos[1]

var graph: [[Int]] = Array(repeating: Array(), count: nodeNum + 1)

for _ in 0..<vertexNum {
    let graphInfo = readLine()!.split(separator: " ").map { Int($0)! }
    
    graph[graphInfo[0]].append(graphInfo[1])
    graph[graphInfo[1]].append(graphInfo[0])
}

var index = 0
var answer = 0

while visitedNodes.count < nodeNum {
    index += 1
    
    if visitedNodes.contains(index) {
        continue
    } else {
        dfs(index, graph)
        answer += 1
    }
}

print(answer)
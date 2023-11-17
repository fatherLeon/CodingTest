import Foundation

func dfs(start: Int) {
    if visited.contains(start) { return }
    
    visited.append(start)
    
    if let _ = graph[start].first {
        graph[start].forEach { index in
            if !visited.contains(index) && answer[index] == -1 {
                answer[index] = answer[start] + 1
            }
            
            dfs(start: index)
        }
    } else {
        return
    }
}

let peopleNum = Int(readLine()!)!
let targetInfos = readLine()!.split(separator: " ").map { Int($0)! }
let num = Int(readLine()!)!

var graph: [[Int]] = Array(repeating: Array(), count: peopleNum + 1)
var answer: [Int] = Array(repeating: -1, count: peopleNum + 1)
var visited: [Int] = []

answer[targetInfos[0]] = 0

for _ in 0..<num {
    let infos = readLine()!.split(separator: " ").map { Int($0)! }
    
    graph[infos[0]].append(infos[1])
    graph[infos[1]].append(infos[0])
}

dfs(start: targetInfos[0])
print(answer[targetInfos[1]])

import Foundation

struct Queue<T> {
    var enqueueStack: [T] = []
    var dequeueStack: [T] = []
    
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

let infos = readLine()!.split(separator: " ").map { Int($0)! }

let subin = infos[0]
let brother = infos[1]

let standardMaxValue = infos.max()! * 2 + 1

var queue = Queue<Int>()
var map: [Int] = Array(repeating: 0, count: standardMaxValue)
var visited: [Bool] = Array(repeating: false, count: standardMaxValue)
var answer: [Int] = Array(repeating: 0, count: standardMaxValue)

visited[subin] = true
queue.enqueue(subin)

while !queue.isEmpty {
    let index = queue.dequeue()!
    let canMovingIndex: [Int] = [index + 1, index - 1, index * 2]
    
    canMovingIndex.filter { value in
        return value < standardMaxValue  && value >= 0 && visited[value] == false && answer[value] == 0
    }
    .forEach { value in
        queue.enqueue(value)
        answer[value] = answer[index] + 1
        visited[value] = true
    }
}

print(answer[brother])

import Foundation

let n = Int(readLine()!)!
let arr = readLine()!.split(separator: " ").map { Int($0)! }

var minValue = Int.max
var answer = (x: 0, y: 0)
var startIndex = 0
var endIndex = arr.count - 1

while startIndex < endIndex {
    if startIndex == endIndex { break }
    
    let value = arr[startIndex] + arr[endIndex]
    
    if abs(value) <= minValue {
        minValue = abs(value)
        answer.x = startIndex
        answer.y = endIndex
    }
    
    if value > 0 { endIndex -= 1 }
    
    if value < 0 { startIndex += 1 }
    
    if value == 0 { break }
}

print(arr[answer.x], terminator: " ")
print(arr[answer.y], terminator: " ")
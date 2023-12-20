import Foundation

func solution(_ k:Int, _ tangerine:[Int]) -> Int {
    var hash: [Int: Int] = [:]
    
    for t in tangerine {
        if hash[t] == nil {
            hash[t] = 1
        } else {
            hash[t]! += 1
        }
    }
    
    let count = hash.values.map { Int($0) }
    var sortedCount = count.sorted(by: <)
    var answer = 0
    var hap = 0
    
    while hap < k {
        let value = sortedCount.popLast()!
        
        hap += value
        answer += 1
    }
    
    
    return answer
}
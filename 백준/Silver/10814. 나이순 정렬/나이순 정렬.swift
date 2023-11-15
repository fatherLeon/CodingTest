import Foundation

struct Member {
    let age: Int
    let name: String
}

let n = Int(readLine()!)!
var members: [Member] = []

for _ in 0..<n {
    let memberInfo = readLine()!.split(separator: " ")
    let age = Int(memberInfo[0])!
    let name = String(memberInfo[1])
    
    members.append(Member(age: age, name: name))
}

members.sorted { lhs, rhs in
    if lhs.age != rhs.age {
        return lhs.age < rhs.age
    } else {
        return false
    }
}
.forEach { member in
    print(member.age, terminator: " ")
    print(member.name)
}

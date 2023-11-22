let info = readLine()!.split(separator: " ").map { Int($0)! }
let arrACount = info[0]
let arrBCount = info[1]
let setA = Set(readLine()!.split(separator: " ").map { Int($0)! })
let setB = Set(readLine()!.split(separator: " ").map { Int($0)! })

let answer = Array(setA.subtracting(setB)).sorted(by: { $0 < $1 })

print(answer.count)
for val in answer {
    print(val, terminator: " ")
}

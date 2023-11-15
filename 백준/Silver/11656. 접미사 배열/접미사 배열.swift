import Foundation

let inputs = Array(readLine()!).map { String($0) }
var answer: [String] = []

for index in 0..<inputs.count {
    answer.append(inputs[index...].joined(separator: ""))
}

answer.sorted { $0 < $1 }
    .forEach { str in
        print(str)
    }

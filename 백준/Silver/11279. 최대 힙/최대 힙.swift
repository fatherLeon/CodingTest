import Foundation

struct MaxHeap<T: Comparable> {
    var heap: Array<T> = []
    var isEmpty: Bool {
        return heap.count <= 1 ? true : false
    }
    
    init() { }
    init(_ data: T) {
        heap.append(data)
        heap.append(data)
    }

    mutating func insert(_ data: T) {
        if heap.isEmpty {
            heap.append(data)
            heap.append(data)
            return
        }
        heap.append(data)
        
        func isMoveUp(_ insertIndex: Int) -> Bool {
            if insertIndex <= 1 {
                return false
            }
            let parentIndex: Int = insertIndex / 2
            return heap[insertIndex] > heap[parentIndex] ? true : false
        }
        
        var insertIndex: Int = heap.count - 1
        while isMoveUp(insertIndex) {
            let parentIndex: Int = insertIndex / 2
            heap.swapAt(insertIndex, parentIndex)
            insertIndex = parentIndex
        }
    }
    
    enum moveDownStatus { case left, right, none }
    
    mutating func pop() -> T? {
        if heap.count <= 1 { return nil }
        
        let returnData = heap[1]
        heap.swapAt(1, heap.count - 1)
        heap.removeLast()
        
        func moveDown(_ poppedIndex: Int) -> moveDownStatus {
            let leftChildIndex = (poppedIndex * 2)
            let rightCildIndex = leftChildIndex + 1
            
            if leftChildIndex >= (heap.count) {
                return .none
            }
            if rightCildIndex >= (heap.count) {
                return heap[leftChildIndex] > heap[poppedIndex] ? .left : .none
            }
            if (heap[leftChildIndex] < heap[poppedIndex]) && (heap[rightCildIndex] < heap[poppedIndex]) {
                return .none
            }
            if (heap[leftChildIndex] > heap[poppedIndex]) && (heap[rightCildIndex] > heap[poppedIndex]) {
                return heap[leftChildIndex] > heap[rightCildIndex] ? .left : .right
            }
            
            return heap[leftChildIndex] > heap[poppedIndex] ? .left : .right
        }
        
        var poppedIndex = 1
        while true {
            switch moveDown(poppedIndex) {
            case .none:
                return returnData
            case .left:
                let leftChildIndex = poppedIndex * 2
                heap.swapAt(poppedIndex, leftChildIndex)
                poppedIndex = leftChildIndex
            case .right:
                let rightChildIndex = (poppedIndex * 2) + 1
                heap.swapAt(poppedIndex, rightChildIndex)
                poppedIndex = rightChildIndex
                
            }
        }
    }
}


var heap = MaxHeap<Int>()

let n = Int(readLine()!)!

for _ in 0..<n {
    let value = Int(readLine()!)!
    
    switch value {
    case 0:
        guard let printAnswer = heap.pop() else {
            print(0)
            continue
        }
        print(printAnswer)
    default:
        heap.insert(value)
    }
}
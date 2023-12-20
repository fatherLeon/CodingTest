import Foundation

func calculateHittingShootingStars(shootingStars: [(x: Int, y: Int)], coordinate: (x: Int, y: Int), L: Int) -> Int {
    let minX = coordinate.x
    let minY = coordinate.y
    let maxX = coordinate.x + L
    let maxY = coordinate.y + L
    
    var answer = 0
    
    for star in shootingStars {
        if star.x >= minX && star.y >= minY && star.x <= maxX && star.y <= maxY {
            answer += 1
        }
    }
    
    return shootingStars.count - answer
}

func solution14658() {
    let tempInfo = readLine()!.split(separator: " ").map { Int($0)! }
    let N = tempInfo[0]
    let M = tempInfo[1]
    let L = tempInfo[2]
    let K = tempInfo[3]
    
    var shootingStars: [(x: Int, y: Int)] = []
    
    for _ in 0..<K {
        let coordinate = readLine()!.split(separator: " ").map { Int($0)! }
        
        shootingStars.append((coordinate[0] - 1, coordinate[1] - 1))
    }
    
    var minHittingShootingStar = Int.max
    
    for x in 0..<K {
        let x = shootingStars[x].x
        for y in 0..<K {
            let y = shootingStars[y].y
            let hittingStars = calculateHittingShootingStars(shootingStars: shootingStars, coordinate: (x, y), L: L)
            
            if hittingStars < minHittingShootingStar {
                minHittingShootingStar = hittingStars
            }
        }
    }
    
    print(minHittingShootingStar)
}

solution14658()
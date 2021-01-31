import Foundation

class Sum {

    var resultsCache: [[Int]]
    var firstValue: Int
    var secondValue: Int

    init(first: Int, second: Int, cacheSize: Int) {
        resultsCache = [[Int]](repeating: [Int](repeating: 0, count: cacheSize), count: cacheSize)

        for i in 0 ..< 10 {
            for j in 0 ..< 10 {
                resultsCache[i][j] = i + j
            }
        }
        firstValue = first
        secondValue = second
    }

    var result: Int {
        return firstValue < resultsCache.count
            && secondValue < resultsCache[firstValue].count
            ? resultsCache[firstValue][secondValue]
            : firstValue + secondValue
    }
}

var calc1 = Sum(first: 0, second: 9, cacheSize: 100).result
var calc2 = Sum(first: 3, second: 8, cacheSize: 20).result

print("Calc1: \(calc1) Calc2: \(calc2)")

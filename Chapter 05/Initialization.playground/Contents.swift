import Foundation

class Sum: NSObject, NSCopying {

    var resultsCache: [[Int]]
    var firstValue: Int
    var secondValue: Int

    init(first: Int, second: Int) {
        resultsCache = [[Int]](repeating: [Int](repeating: 0, count: 10), count: 10)

        for i in 0 ..< 10 {
            for j in 0 ..< 10 {
                resultsCache[i][j] = i + j
            }
        }
        firstValue = first
        secondValue = second
    }

    private init(first: Int, second: Int, cache: [[Int]]) {
        firstValue = first
        secondValue = second
        resultsCache = cache
    }

    var Result: Int {
        return firstValue < resultsCache.count
            && secondValue < resultsCache[firstValue].count
            ? resultsCache[firstValue][secondValue]
            : firstValue + secondValue
    }

    func copy(with zone: NSZone? = nil) -> Any {

        return Sum(first: firstValue,
                   second: secondValue,
                   cache: resultsCache)
    }
}

var prototype = Sum(first: 0, second: 9)
var calc1 = prototype.Result
var clone = prototype.copy() as! Sum
clone.firstValue = 3
clone.secondValue = 8
var calc2 = clone.Result

print("Calc1: \(calc1) Calc2: \(calc2)")

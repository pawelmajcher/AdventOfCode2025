import Algorithms

struct Day02: AdventDay {
  var data: String

  var ranges: [ClosedRange<Int>] {
    data
      .trimmingCharacters(in: .whitespacesAndNewlines)
      .split(separator: ",").map {
        let boundEnds = $0.split(separator: "-")
        let boundMin: Int = Int(boundEnds[0])!
        let boundMax: Int = Int(boundEnds[1])!
        
        return boundMin...boundMax
      }
  }

  func part1() -> Int {
    let invalidNumbers = ranges.flatMap { range in
      range.filter { number in
        let numberString = String(number)
        guard numberString.count.isMultiple(of: 2) else { return false }
        
        let firstHalf = numberString.prefix(numberString.count / 2)
        let secondHalf = numberString.suffix(numberString.count / 2)
        
        return firstHalf == secondHalf
      }
    }
    
    return invalidNumbers.reduce(0, +)
  }

  func part2() -> Int {
    let invalidNumbers = ranges.flatMap { range in
      range.filter { number in
        let numberString = String(number)
        let repeatingRegex = /([0-9]+)\1+/
        
        return ((try! repeatingRegex.wholeMatch(in: numberString)) != nil)
      }
    }
    
    return invalidNumbers.reduce(0, +)
  }
}

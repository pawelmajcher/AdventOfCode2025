import Algorithms

struct Day05: AdventDay {
  var data: String
  
  var dataSplitRange: Range<String.Index> {
    data.firstRange(of: "\n\n")!
  }

  var freshRangesString: some StringProtocol {
    data[data.startIndex..<dataSplitRange.lowerBound]
  }
  
  var availableIngredientsString: some StringProtocol {
    data[dataSplitRange.upperBound..<data.endIndex]
  }
  
  var freshIngredients: RangeSet<Int> {
    RangeSet(
      freshRangesString
        .split(separator: "\n")
        .map { rangeString in
          let rangeBounds = rangeString
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .split(separator: "-")
          return Int(rangeBounds[0])!..<(Int(rangeBounds[1])!+1)
        }
    )
  }
  
  var availableIngredients: Set<Int> {
    Set(
      availableIngredientsString
        .split(separator: "\n")
        .compactMap { Int($0) }
    )
  }

  func part1() -> Int {
    return availableIngredients.filter { ingredient in
      freshIngredients.contains(ingredient)
    }.count
  }

  func part2() -> Int {
    freshIngredients.ranges.reduce(0) { partialCount, range in
      partialCount + range.count
    }
  }
}

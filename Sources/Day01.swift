import Algorithms

struct Day01: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  var entities: [Int] {
    data.split(separator: "\n").compactMap {
        switch $0.first {
            case "L":
            return Int($0.dropFirst())! * -1
            case "R":
            return Int($0.dropFirst())!
            default:
            return nil
        }
    }
  }

  func part1() -> Int {
    print(entities.reductions(50, +))

    // Calculate the sum of the first set of input data
    return entities.reductions(50, +)
        .map { $0 % 100 == 0 ? 1 : 0 }
        .reduce(0, +)
  }

  func part2() -> Int {
    return entities
        .reductions(50, +)
        .adjacentPairs()
        .map { start, finish in
            if start < finish {
                let startQ = Int((Double(start) / 100).rounded(.down))
                let finishQ = Int((Double(finish) / 100).rounded(.down))

                return abs(startQ - finishQ)
            } else {
                let startQ = Int((Double(start - 1) / 100).rounded(.down))
                let finishQ = Int((Double(finish - 1) / 100).rounded(.down))

                return abs(startQ - finishQ)
            }
        }
        .reduce(0, +)
  }
}
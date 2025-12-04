import Algorithms
import BitCollections

struct Day04: AdventDay {
  var data: String
  
  var rollBitmap: BitArray {
    BitArray(
      data.compactMap {
        switch $0 {
        case "@":
          return true
        case ".":
          return false
        default:
          return nil
        }
      }
    )
  }
  
  let rollDiagramWidth: Int = 140
  
  func neighborIndexes(of rollId: Int) -> Set<Int> {
    switch rollId {
    case let rollId where rollId % rollDiagramWidth == 0:
      [
        rollId - rollDiagramWidth,
        rollId - rollDiagramWidth + 1,
        rollId + 1,
        rollId + rollDiagramWidth,
        rollId + rollDiagramWidth + 1
      ]
    case let rollId where rollId % rollDiagramWidth == rollDiagramWidth - 1:
      [
        rollId - rollDiagramWidth,
        rollId - rollDiagramWidth - 1,
        rollId - 1,
        rollId + rollDiagramWidth,
        rollId + rollDiagramWidth - 1
      ]
    case let rollId:
      [
        rollId - rollDiagramWidth - 1,
        rollId - rollDiagramWidth,
        rollId - rollDiagramWidth + 1,
        rollId - 1,
        rollId + 1,
        rollId + rollDiagramWidth - 1,
        rollId + rollDiagramWidth,
        rollId + rollDiagramWidth + 1
      ]
    }
  }

  func part1() -> Int {
    let rollIndexes = BitSet.Counted(rollBitmap)
    
    let neighborCounts = rollIndexes.map { rollId in
      let neighborIndexes: Set<Int> = neighborIndexes(of: rollId)
      return neighborIndexes.count(where: rollIndexes.contains)
    }
    
    return neighborCounts.count(where: { $0 < 4 })
  }

  func part2() -> Int {
    var rollIndexes = BitSet.Counted(rollBitmap)
    var removedRollsRunningTotal = 0
    
    repeat {
      let rollsToRemove: BitSet.Counted = rollIndexes.filter { rollId in
        return neighborIndexes(of: rollId).count(where: rollIndexes.contains) < 4
      }
      
      if rollsToRemove.count == 0 { break }
      
      removedRollsRunningTotal += rollsToRemove.count
      
      rollIndexes.subtract(rollsToRemove)
      
    } while true
    
    return removedRollsRunningTotal
  }
}

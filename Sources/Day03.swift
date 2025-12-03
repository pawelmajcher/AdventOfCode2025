import Algorithms

struct Day03: AdventDay {
  var data: String

  var batteryBanks: [[Int]] {
    data.split(separator: "\n").map { bankString in
      bankString.compactMap { $0.wholeNumberValue }
    }.filter { !$0.isEmpty }
  }

  func part1() -> Int {
    let maxJoltageFromBank = batteryBanks.map { bank in
      let firstBatteryLookup = bank[0 ..< bank.endIndex-1]
      let firstBatteryValue = firstBatteryLookup.max()!
      let firstBatteryIndex = firstBatteryLookup.firstIndex(of: firstBatteryValue)!
      
      let secondBatteryLookup = bank.suffix(from: firstBatteryIndex + 1)
      let secondBatteryValue = secondBatteryLookup.max()!
      
      return firstBatteryValue * 10 + secondBatteryValue
    }
    
    return maxJoltageFromBank.reduce(0, +)
  }

  func part2() -> Int {
    let maxJoltageFromBank = batteryBanks.map { bank in
      var remainingBank = bank
      var accumulatingJoltage: Int = 0
      
      for remainingDigits in (0 ..< 12).reversed() {
        print(remainingBank)
        let maxJoltageBattery = remainingBank.getMaxJoltageBattery(saving: remainingDigits)
        accumulatingJoltage +=
          maxJoltageBattery * (0..<remainingDigits).reduce(1) { value, _ in 10 * value }
      }
      
      return accumulatingJoltage
    }
    
    return maxJoltageFromBank.reduce(0, +)
  }
}

extension Array where Element == Int {
  mutating func getMaxJoltageBattery(saving remainingDigits: Int = 0) -> Int {
    let batteryLookup = self[0 ..< self.endIndex - remainingDigits]
    let batteryValue = batteryLookup.max()!
    let batteryIndex = batteryLookup.firstIndex(of: batteryValue)!
    
    self.removeFirst(batteryIndex + 1)
    
    return batteryValue
  }
}

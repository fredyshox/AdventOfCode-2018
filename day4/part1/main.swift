//
//  main.swift
//
//  Created by Kacper Raczy on 05.12.2018.
//
//

import Foundation

typealias GuardInfo = (totalTime: Int, logs: [Log])

let calendar: Calendar = {
  var c = Calendar(identifier: .gregorian)
  c.timeZone = TimeZone(secondsFromGMT: 0)!

  return c
}()

// sorting causes O(nlogn)
// T(n) = O(nlogn) + O(n) = O(nlogn)
func calculateSleepTime(_ logs: inout [Log]) -> (Int, [Int: GuardInfo]) {
  guard logs.count > 0 else {
    fatalError("Empty input.")
  }

  logs.sort(by: { $0.date < $1.date })
  var result: [Int: GuardInfo] = [:]
  var prev: Log?
  var currentId: Int?
  var longestSleeperId: Int?
  for log in logs {
    switch log.event {
    case .shift(let id):
      if result[id] == nil {
        result[id] = (totalTime: 0, logs: [])
      }
      currentId = id
    case .wakesUp:
      guard let currentId = currentId else {
        fatalError("Missing guard id.")
      }

      result[currentId]!.totalTime += Int(DateInterval(start: prev!.date, end: log.date).duration) / 60
      result[currentId]!.logs += [log]
      if longestSleeperId == nil || result[currentId]!.totalTime > result[longestSleeperId!]!.totalTime {
        longestSleeperId = currentId
      }
    case .fallsAsleep:
      guard let currentId = currentId else {
        fatalError("Missing guard id.")
      }

      result[currentId]!.logs += [log]
    }
    prev = log
  }

  // force
  return (longestSleeperId!, result)
}

var logs: [Log] = []
while let line = readLine(strippingNewline: true) {
  logs.append(parseLog(line))
}
let (id ,infoDict) = calculateSleepTime(&logs)
print("id: \(id), total: \(infoDict[id]!.totalTime)")
// number of logs must be even
let guardLogs = infoDict[id]!.logs
var hourVec = [Int](repeating: 0, count: 60)
// worst case O(n), but space complexity is better this way
for i in stride(from: 0, to: guardLogs.count, by: 2) {
  let startMin = calendar.component(.minute, from: guardLogs[i].date)
  let endMin = calendar.component(.minute, from: guardLogs[i + 1].date)
  for m in startMin..<endMin {
    hourVec[m] += 1
  }
}

let result = id * hourVec.argmax()!
print("Result: \(result)")

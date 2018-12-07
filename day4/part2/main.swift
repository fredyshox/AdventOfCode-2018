//
//  main.swift
//
//  Created by Kacper Raczy on 05.12.2018.
//
// Easiest way possible: 60 element vector representing each minute for each guard
// As input is not so big 60 bytes will be sufficient for each guard
//

import Foundation

let calendar: Calendar = {
  var c = Calendar(identifier: .gregorian)
  c.timeZone = TimeZone(secondsFromGMT: 0)!

  return c
}()

func sleepMinutes(_ logs: inout [Log]) -> [Int: [UInt8]] {
  logs.sort(by: { $0.date < $1.date })
  var result: [Int: [UInt8]] = [:]
  var prev: Log?
  var currentId: Int?
  for log in logs {
    switch log.event {
    case .shift(let id):
      if result[id] == nil {
        result[id] = [UInt8](repeating: 0, count: 60)
      }
      currentId = id
    case .wakesUp:
      guard let currentId = currentId, let prev = prev else {
        fatalError("Incompatible input: logs array")
      }

      let startMin = calendar.component(.minute, from: prev.date)
      let endMin = calendar.component(.minute, from: log.date)
      for m in startMin..<endMin {
        result[currentId]![m] += 1
      }
    default: break
    }
    prev = log
  }

  return result
}

var logs: [Log] = []
while let line = readLine(strippingNewline: true) {
  logs.append(parseLog(line))
}
let report = sleepMinutes(&logs)
var result: (id: Int, total: Int, minute: Int) = (0,0,0)
for m in 0..<60 {
  for (id, hourVec) in report {
    if hourVec[m] > result.total {
      result = (id: id, total: Int(hourVec[m]), minute: m)
    }
  }
}
print("Result: id: \(result.id), minute: \(result.minute), total: \(result.id * result.minute)")

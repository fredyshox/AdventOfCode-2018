//
//  Parsing.swift
//
//  Created by Kacper Raczy on 06.12.2018.
//

import Foundation

enum GuardEvent {
  case shift(id: Int)
  case fallsAsleep
  case wakesUp
}

struct Log {
  let date: Date
  let event: GuardEvent
}

enum ParseError: LocalizedError, CustomStringConvertible {
  case missingGuardId(String)
  case incompatibleDateFormat(String)
  case incompatibleInput(String)

  var description: String {
    switch self {
    case .incompatibleInput(let str), .missingGuardId(let str), .incompatibleDateFormat(let str):
      return "Incompatible input \(str)"
    }
  }

  var errorDescription: String? {
    return description
  }
}

fileprivate let dateFormatter: DateFormatter = {
  let df = DateFormatter()
  df.dateFormat = "[yyyy-MM-dd HH:mm]"
  df.timeZone = TimeZone(secondsFromGMT: 0)
  return df
}()

func parseLog(_ line: String) -> Log {
  let scanner = Scanner(string: line)
  var dateStr: NSString?
  scanner.scanUpToCharacters(from: .letters, into: &dateStr)
  do {
    guard dateStr != nil, let date = dateFormatter.date(from: dateStr! as String) else {
      throw ParseError.incompatibleDateFormat(line)
    }
    let remainder = line.dropFirst(scanner.scanLocation)
    var event: GuardEvent!
    switch remainder {
    case let g where g.contains("Guard"):
      guard let idRange = g.range(of: "#[0-9]+", options: .regularExpression) else {
        throw ParseError.missingGuardId(line)
      }
    let idStr = g[idRange].dropFirst()
      let id = Int(idStr)!
      event = .shift(id: id)
    case let s where s.hasSuffix("falls asleep"):
      event = .fallsAsleep
    case let s where s.hasSuffix("wakes up"):
      event = .wakesUp
    default:
      throw ParseError.incompatibleInput(line)
    }

    return Log(date: date, event: event)
  } catch let error {
    fatalError(error.localizedDescription)
  }
}

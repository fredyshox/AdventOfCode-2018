//
//  main.swift
//  day5 part2
//
//  Created by Kacper Raczy on 07.12.2018.
//

import Foundation

func producePolymer(from inputString: String, ignoringCharactersIn ignoreString: String = "") -> String {
  var polymerStr = ""
  let ignoreScalars = ignoreString.unicodeScalars
  for scalar in inputString.unicodeScalars where scalar.isLetter && !ignoreScalars.contains(scalar) {
    if let prevScalar = polymerStr.unicodeScalars.last, prevScalar.toLowercase == scalar.toLowercase {
      if prevScalar.isUppercaseLetter != scalar.isUppercaseLetter {
        polymerStr.removeLast()
        continue
      }
    }
    polymerStr.append(Character(scalar))
  }

  return polymerStr
}

guard CommandLine.arguments.count > 1 else {
  printErr("Usage: program inputFile")
  exit(1)
}

let filePath = CommandLine.arguments[1]
guard let content = try? String(contentsOfFile: filePath, encoding: .utf8) else {
  printErr("Invalid file path: \(filePath)")
  exit(2)
}

var minCount: Int?
for i in 65...90 {
  let scalar = Unicode.Scalar(i)!
  let ignoreChars = "\(scalar)\(scalar.toLowercase!)"
  let polymer = producePolymer(from: content, ignoringCharactersIn: ignoreChars)
  if minCount == nil || polymer.count < minCount! {
    minCount = polymer.count
  }
}

print("Length of smallest polymer: \(minCount ?? -1)")

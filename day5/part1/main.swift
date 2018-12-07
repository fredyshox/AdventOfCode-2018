//
//  main.swift
//  day5 part1
//
//  Created by Kacper Raczy on 07.12.2018.
//

import Foundation

guard CommandLine.arguments.count > 1 else {
  printErr("Usage: program inputFile")
  exit(1)
}

let filePath = CommandLine.arguments[1]
let url = URL(fileURLWithPath: filePath)
let fileInputStream = InputStream(url: url)!

var polymerStr = ""
var byte: UInt8 = 0
fileInputStream.open()
while fileInputStream.hasBytesAvailable {
  fileInputStream.read(&byte, maxLength: 1)
  let scalar = Unicode.Scalar(byte)
  if scalar.isLetter {
    if let prevScalar = polymerStr.unicodeScalars.last, prevScalar.toLowercase == scalar.toLowercase {
      if prevScalar.isUppercaseLetter != scalar.isUppercaseLetter {
        polymerStr.removeLast()
        continue
      }
    }
    polymerStr.append(Character(scalar))
  }
}

fileInputStream.close()
print("Count: \(polymerStr.count)")

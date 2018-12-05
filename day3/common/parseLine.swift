//
//  parseLine.swift
//
//  Created by Kacper Raczy on 05.12.2018.
//

import Foundation

func parseLine(_ line: String) -> Claim {
  let scanner = Scanner(string: line)
  scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#@,:x ")
  var id = 0, x = 0, y = 0, width = 0, height = 0
  scanner.scanInt(&id)
  scanner.scanInt(&x)
  scanner.scanInt(&y)
  scanner.scanInt(&width)
  scanner.scanInt(&height)
  return Claim(id: id, origin: (Int16(x), Int16(y)), size: (Int16(width), Int16(height)))
}

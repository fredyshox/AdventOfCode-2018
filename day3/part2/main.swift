//
//  part2.swift
//
//  Created by Kacper Raczy on 05.12.2018.
//

typealias Id2Bound = (id: Int, bound: Bound)

// set containing ids of claims that overlap
let fabricSize = 1000
var overlapDict: [Int: Bool] = [:]
var matrix = [[Id2Bound]](repeating: [], count: fabricSize)
while let line = readLine(strippingNewline: true) {
  let claim = parseLine(line)
  overlapDict[claim.id] = false
  let lowerBound = Bound.lower(claim.xRange.lowerBound)
  let upperBound = Bound.upper(claim.xRange.upperBound)
  for y in claim.yRange {
    matrix[Int(y)] += [(claim.id, lowerBound), (claim.id, upperBound)]
  }
}

for var row in matrix {
  row.sort(by: { $0.bound < $1.bound })
  var prev: Id2Bound?
  for item in row {
    // if neighbouring items have diff. ids and are not )(
    if prev != nil && prev!.id != item.id && (!prev!.bound.isUpper || !item.bound.isLower) {
      overlapDict[prev!.id] = true
      overlapDict[item.id] = true
    }
    prev = item
  }
}

// there is only one such id
let nonOverlapping = overlapDict.first{ !$0.value }!.key
print("Non-overlapping claim id: \(nonOverlapping)")

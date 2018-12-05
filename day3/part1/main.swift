//
//  part1.swift
//
//  Created by Kacper Raczy on 05.12.2018.
//

// load lower(open) and upper(close) bounds into the container
let fabricSize = 1000
var matrix = [[Bound]](repeating: [], count: fabricSize)
var overlaps = 0
while let line = readLine(strippingNewline: true) {
  let claim = parseLine(line)
  let lowerBound = Bound.lower(claim.xRange.lowerBound)
  let upperBound = Bound.upper(claim.xRange.upperBound)
  for y in claim.yRange {
    matrix[Int(y)] += [lowerBound, upperBound]
  }
}

// evaluate overlaping using stack
for var row in matrix {
  var stack: [Bound] = []
  row.sort()
  for bound in row {
    if bound.isUpper {
      if stack.count == 2 {
        let top = stack.last!
        overlaps += Int(bound.value - top.value + 1)
      }
      stack.removeLast()
    } else {
      stack.append(bound)
    }
  }
  assert(stack.isEmpty, "Error non empty stack")
}

print("Overlap count: \(overlaps)")

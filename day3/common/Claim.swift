//
//  Claim.swift
//
//  Created by Kacper Raczy on 05.12.2018.
//

struct Claim {
  let id: Int
  let origin: (x: Int16, y: Int16)
  let size: (width: Int16, height: Int16)

  var xRange: ClosedRange<Int16> {
    return origin.x...(origin.x + size.width - 1)
  }

  var yRange: ClosedRange<Int16> {
    return origin.y...(origin.y + size.height - 1)
  }
}

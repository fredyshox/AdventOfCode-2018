//
//  Bound.swift
//
//  Created by Kacper Raczy on 05.12.2018.
//

enum Bound: Comparable, CustomStringConvertible {
  case lower(Int16)
  case upper(Int16)

  var value: Int16 {
    switch self {
    case .lower(let value), .upper(let value):
      return value
    }
  }

  var isLower: Bool {
    if case .lower = self {
      return true
    } else {
      return false
    }
  }

  var isUpper: Bool {
    if case .upper = self {
      return true
    } else {
      return false
    }
  }

  var description: String {
    switch self {
    case .lower(let value):
      return "lower(\(value))"
    case .upper(let value):
      return "upper(\(value))"
    }
  }

  // evaluate value then if eq lower always < upper
  static func < (lhs: Bound, rhs: Bound) -> Bool {
    // if eq, then eval if lower or upper
    if lhs.value == rhs.value {
      return lhs.isLower && rhs.isUpper
    }
    return lhs.value < rhs.value
  }

  static func == (lhs: Bound, rhs: Bound) -> Bool {
    return (lhs.value == lhs.value) && (lhs.isLower == rhs.isLower)
  }

}

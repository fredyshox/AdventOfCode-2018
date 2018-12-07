//
//  util.swift
//  day5 
//
//  Created by Kacper Raczy on 07.12.2018.
//

import Foundation

func printErr(_ item: CustomStringConvertible = "") {
  fputs("\(item.description)\n", stderr)
}

extension Unicode.Scalar {
  var isLetter: Bool {
    return (value >= 65 && value <= 90) || (value >= 97 && value <= 122)
  }

  var isLowercaseLetter: Bool {
    return (value >= 97 && value <= 122)
  }

  var isUppercaseLetter: Bool {
    return (value >= 65 && value <= 90)
  }

  var toLowercase: Unicode.Scalar? {
    if isUppercaseLetter {
      return Unicode.Scalar(value + 32)
    } else if isLowercaseLetter {
      return self
    } else {
      return nil
    }
  }
}

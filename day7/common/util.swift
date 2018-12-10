//
//  util.swift
//  day7 common
//
//  Created by Kacper Raczy on 09.12.2018.
//

import Foundation

func printErr(_ item: CustomStringConvertible = "") {
  fputs("\(item.description)\n", stderr)
}

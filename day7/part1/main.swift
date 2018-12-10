//
//  main.swift
//  day7 part1
//
//  Created by Kacper Raczy on 09.12.2018.
//

import Foundation

func parseGraph(lines: [String]) -> (startPoints: [Character], graph: JobGraph) {
  var graph = JobGraph()
  var startingChars: [Character] = []
  for line in lines {
    let nodeChar = line[line.index(line.startIndex, offsetBy: 36)]
    let preqChar = line[line.index(line.startIndex, offsetBy: 5)]
    graph.add(value: nodeChar)
    graph.add(value: preqChar)
    graph.connect(preqChar, nodeChar)
  }

  for (key, node) in graph.nodes {
    if node.prerequisites == 0 {
      startingChars.append(key)
    }
  }

  return (startPoints: startingChars, graph: graph)
}

guard CommandLine.arguments.count > 1 else {
  printErr("Usage: program inputFile")
  exit(1)
}

let filePath = CommandLine.arguments[1]
guard let fileString = try? String(contentsOfFile: filePath, encoding: .utf8) else {
  printErr("Invalid file path: \(filePath)")
  exit(2)
}

let lines = fileString.split(separator: "\n")
              .filter({ $0.count > 0 })
              .map({ String($0) })
let (start, graph) = parseGraph(lines: lines)
let str = graph.instructionOrder(startPoints: start)
print("Result: \(str)")

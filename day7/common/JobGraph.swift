//
//  JobGraph.swift
//  day7 common
//
//  Created by Kacper Raczy on 09.12.2018.
//

import Foundation

struct JobGraph {
  struct Node {
    let value: Character
    var prerequisites: Int

    init(value: Character, prerequisites: Int = 0) {
      self.value = value
      self.prerequisites = prerequisites
    }
  }

  var nodes: [Character: Node] = [:]
  var adjList: [Character: [Character]] = [:]

  mutating func connect(_ n1: Character, _ n2: Character) {
    guard nodes[n1] != nil && nodes[n2] != nil else {
      return
    }
    nodes[n2]!.prerequisites += 1
    adjList[n1]!.append(n2)
  }

  mutating func addOrUpdate(value: Character) {
    nodes[value] = Node(value: value)
  }

  mutating func add(value: Character) {
    if nodes[value] == nil {
      nodes[value] = Node(value: value)
      adjList[value] = []
    }
  }

  func instructionOrder(startPoints: [Character]) -> String {
    guard startPoints.reduce(true, { $0 && nodes[$1] != nil }) else {
      return ""
    }

    // breadth first search
    var graph = self
    var visited = Set<Character>()
    var queue = PriorityQueue<Character>(sort: { $0 < $1 })
    var result: String = ""
    var s: Character!
    for start in startPoints {
      visited.insert(start)
      queue.enqueue(start)
    }

    while !queue.isEmpty {
      s = queue.dequeue()!
      result.append(s)
      for neighbour in graph.adjList[s]! where !visited.contains(neighbour) {
        var neighbourNode = graph.nodes[neighbour]!
        if neighbourNode.prerequisites != 0 {
          neighbourNode.prerequisites -= 1
          graph.nodes[neighbour] = neighbourNode
        }

        if neighbourNode.prerequisites == 0 {
          visited.insert(neighbour)
          queue.enqueue(neighbour)
        }
      }
    }

    return result
  }

}

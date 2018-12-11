#!/usr/bin/env python3

import sys

class Node:
    def __init__(self, info, parent = None):
        self.parent = parent
        self.info = info
        self.children = []
        self.metadata = []

    def addChild(self, child):
        self.children.append(child)

    def addMetadata(self, data):
        self.metadata.append(data)

    def metadataSum(self):
        return sum(self.metadata)

    def metadataSum2(self):
        current = self


class NodeInfo:
    def __init__(self, childc, metac):
        self.childc = childc
        self.metac = metac

# input too large causing stack overflow
# should be ok for smaller input
def processNode(input, index = 0):
    node = Node()
    childCount = input[index]
    metaCount = input[index + 1]
    for i in range(childCount):
        child, index = processNode(input, index = index + 2)
        node.addChild(child)
    for i in range(index, metaCount):
        meta = input[index]
        node.addMetadata(meta)
    return node, index

# iterative approach
def processNodesIterative(input):
    metaSum = 0
    rootInfo = NodeInfo(input[0], input[1])
    root = Node(rootInfo)
    parent = root
    index = 2
    nodec = 0
    while index < len(input):
        info = NodeInfo(input[index], input[index + 1])
        node = Node(info, parent=parent)
        index += 2
        parent.addChild(node)
        parent.info.childc -= 1
        nodec += 1
        if node.info.childc == 0:
            # node is leaf
            index = collectMetadata(input, index, node)
            metaSum += node.metadataSum()
            while (parent is not None) and (parent.info.childc == 0):
                index = collectMetadata(input, index, parent)
                metaSum += parent.metadataSum()
                parent = parent.parent
        else:
            # node is not leaf
            parent = node
    return root, metaSum

def collectMetadata(input, index, node):
    for i in range(index, index + node.info.metac):
        node.addMetadata(input[i])
    return i + 1

def main(argv):
    if len(argv) == 0:
        print("Usage: python3 program.py inputFile")
        exit(1)
    filePath = argv[0]
    with open(filePath, "r") as f:
        fileStr = f.read()
        integers = [int(s) for s in fileStr.split(" ")]
        root, metaSum = processNodesIterative(integers)
        print("Metadata sum: " + str(metaSum))

if __name__ == "__main__":
    main(sys.argv[1:])

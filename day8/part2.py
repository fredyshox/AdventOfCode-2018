#!/usr/bin/env python3

import sys
import tree

def nodeValue(node):
    result = 0
    if node.hasChildren():
        valueArr = [None] * len(node.children)
        for m in node.metadata:
            if 0 <= (m - 1) < len(node.children):
                child = node.children[m - 1]
                if valueArr[m - 1] is None:
                    valueArr[m - 1] = nodeValue(child)
                result += valueArr[m - 1]
    else:
        result = node.metadataSum()
    return result

def main(argv):
    if len(argv) == 0:
        print("Usage: program.py inputFile")
        exit(1)

    filePath = argv[0]
    with open(filePath, "r") as f:
        fileStr = f.read()
        integers = [int(s) for s in fileStr.split(" ")]
        root = tree.processNodesIterative(integers)
        rootValue = nodeValue(root)
        print("Root value: " + str(rootValue))

if __name__ == "__main__":
    main(sys.argv[1:])

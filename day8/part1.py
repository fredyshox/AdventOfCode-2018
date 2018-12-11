#!/usr/bin/env python3

import sys
import tree

def metadataSum(node):
    s = node.metadataSum()
    for child in node.children:
        s += metadataSum(child)
    return s

def main(argv):
    if len(argv) == 0:
        print("Usage: program.py inputFile")
        exit(1)

    filePath = argv[0]
    with open(filePath, "r") as f:
        fileStr = f.read()
        integers = [int(s) for s in fileStr.split(" ")]
        root = tree.processNodesIterative(integers)
        print("Metadata sum: " + str(metadataSum(root)))

if __name__ == "__main__":
    main(sys.argv[1:])

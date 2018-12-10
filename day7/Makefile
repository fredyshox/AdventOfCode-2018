all: part1.o part2.o

part1.o: part1/main.swift
	swiftc -o $@ part1/main.swift lib/*.swift common/*.swift

part2.o: part2/main.swift
	swiftc -o $@ part2/main.swift lib/*.swift common/*.swift

clean:
	rm -rf part1.o part2.o

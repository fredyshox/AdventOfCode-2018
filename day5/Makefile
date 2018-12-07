all: part1.o part2.o

part1.o: part1/main.swift
	swiftc -o $@ part1/main.swift util.swift

part2.o: part2/main.swift
	swiftc -o $@ part2/main.swift util.swift

clean:
	rm -rf part1.o part2.o

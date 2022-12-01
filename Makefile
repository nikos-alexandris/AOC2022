all: day1

day1:
	mkdir -p build/day1
	ghc -hidir build/day1 -odir build/day1 -o build/day1/day1 src/day1.hs

.PHONY: clean
clean:
	rm -rf build
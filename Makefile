BUILD_DIR=./build

.PHONY: all
all: build

.PHONY: build
build: ${BUILD_DIR}/day01/Day01 ${BUILD_DIR}/day02/Day02 ${BUILD_DIR}/day03/Day03 ${BUILD_DIR}/day04/Day04 ${BUILD_DIR}/day05/Day05 ${BUILD_DIR}/day06/Day06 ${BUILD_DIR}/day07/Day07 ${BUILD_DIR}/day08/Day08 ${BUILD_DIR}/day09/Day09 ${BUILD_DIR}/day10/Day10

.PHONY:run
run: build
	@${BUILD_DIR}/day01/Day01
	@${BUILD_DIR}/day02/Day02
	@${BUILD_DIR}/day03/Day03
	@${BUILD_DIR}/day04/Day04
	@${BUILD_DIR}/day05/Day05
	@${BUILD_DIR}/day06/Day06
	@${BUILD_DIR}/day07/Day07
	@${BUILD_DIR}/day08/Day08
	@${BUILD_DIR}/day09/Day09
	@${BUILD_DIR}/day10/Day10

${BUILD_DIR}/day01/Day01: src/Day01.hs
	mkdir -p ${BUILD_DIR}/day01
	ghc -O2 -hidir ${BUILD_DIR}/day01 -odir ${BUILD_DIR}/day01 -o $@ $<

${BUILD_DIR}/day02/Day02: src/Day02.hs
	mkdir -p ${BUILD_DIR}/day02
	ghc -O2 -hidir ${BUILD_DIR}/day02 -odir ${BUILD_DIR}/day02 -o $@ $<

${BUILD_DIR}/day03/Day03: src/Day03.hs
	mkdir -p ${BUILD_DIR}/day03
	ghc -O2 -hidir ${BUILD_DIR}/day03 -odir ${BUILD_DIR}/day03 -o $@ $<

${BUILD_DIR}/day04/Day04: src/Day04.hs
	mkdir -p ${BUILD_DIR}/day04
	ghc -O2 -hidir ${BUILD_DIR}/day04 -odir ${BUILD_DIR}/day04 -o $@ $<

${BUILD_DIR}/day05/Day05: src/Day05.hs
	mkdir -p ${BUILD_DIR}/day05
	ghc -O2 -hidir ${BUILD_DIR}/day05 -odir ${BUILD_DIR}/day05 -o $@ $<

${BUILD_DIR}/day06/Day06: src/Day06.hs
	mkdir -p ${BUILD_DIR}/day06
	ghc -O2 -hidir ${BUILD_DIR}/day06 -odir ${BUILD_DIR}/day06 -o $@ $<

${BUILD_DIR}/day07/Day07: src/Day07.hs
	mkdir -p ${BUILD_DIR}/day07
	ghc -O2 -hidir ${BUILD_DIR}/day07 -odir ${BUILD_DIR}/day07 -o $@ $<

${BUILD_DIR}/day08/Day08: src/Day08.hs
	mkdir -p ${BUILD_DIR}/day08
	ghc -O2 -hidir ${BUILD_DIR}/day08 -odir ${BUILD_DIR}/day08 -o $@ $<

${BUILD_DIR}/day09/Day09: src/Day09.hs
	mkdir -p ${BUILD_DIR}/day09
	ghc -O2 -hidir ${BUILD_DIR}/day09 -odir ${BUILD_DIR}/day09 -o $@ $<

${BUILD_DIR}/day10/Day10: src/Day10.hs
	mkdir -p ${BUILD_DIR}/day10
	ghc -O2 -hidir ${BUILD_DIR}/day10 -odir ${BUILD_DIR}/day10 -o $@ $<

.PHONY: clean
clean:
	rm -rf ${BUILD_DIR}
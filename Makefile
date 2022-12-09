BUILD_DIR=./build

.PHONY: all
all: build

.PHONY: build
build: ${BUILD_DIR}/day1/Day1 ${BUILD_DIR}/day2/Day2 ${BUILD_DIR}/day3/Day3 ${BUILD_DIR}/day4/Day4 ${BUILD_DIR}/day5/Day5 ${BUILD_DIR}/day6/Day6 ${BUILD_DIR}/day7/Day7 ${BUILD_DIR}/day8/Day8

.PHONY:run
run: build
	@${BUILD_DIR}/day1/Day1
	@${BUILD_DIR}/day2/Day2
	@${BUILD_DIR}/day3/Day3
	@${BUILD_DIR}/day4/Day4
	@${BUILD_DIR}/day5/Day5
	@${BUILD_DIR}/day6/Day6
	@${BUILD_DIR}/day7/Day7
	@${BUILD_DIR}/day8/Day8

${BUILD_DIR}/day1/Day1: src/Day1.hs
	mkdir -p ${BUILD_DIR}/day1
	ghc -hidir ${BUILD_DIR}/day1 -odir ${BUILD_DIR}/day1 -o $@ $<

${BUILD_DIR}/day2/Day2: src/Day2.hs
	mkdir -p ${BUILD_DIR}/day2
	ghc -hidir ${BUILD_DIR}/day2 -odir ${BUILD_DIR}/day2 -o $@ $<

${BUILD_DIR}/day3/Day3: src/Day3.hs
	mkdir -p ${BUILD_DIR}/day3
	ghc -hidir ${BUILD_DIR}/day3 -odir ${BUILD_DIR}/day3 -o $@ $<

${BUILD_DIR}/day4/Day4: src/Day4.hs
	mkdir -p ${BUILD_DIR}/day4
	ghc -hidir ${BUILD_DIR}/day4 -odir ${BUILD_DIR}/day4 -o $@ $<

${BUILD_DIR}/day5/Day5: src/Day5.hs
	mkdir -p ${BUILD_DIR}/day5
	ghc -hidir ${BUILD_DIR}/day5 -odir ${BUILD_DIR}/day5 -o $@ $<

${BUILD_DIR}/day6/Day6: src/Day6.hs
	mkdir -p ${BUILD_DIR}/day6
	ghc -hidir ${BUILD_DIR}/day6 -odir ${BUILD_DIR}/day6 -o $@ $<

${BUILD_DIR}/day7/Day7: src/Day7.hs
	mkdir -p ${BUILD_DIR}/day7
	ghc -hidir ${BUILD_DIR}/day7 -odir ${BUILD_DIR}/day7 -o $@ $<

${BUILD_DIR}/day8/Day8: src/Day8.hs
	mkdir -p ${BUILD_DIR}/day8
	ghc -hidir ${BUILD_DIR}/day8 -odir ${BUILD_DIR}/day8 -o $@ $<

.PHONY: clean
clean:
	rm -rf ${BUILD_DIR}
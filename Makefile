SRC = ./src
BIN = ./bin
BOOTFILE = boot.asm
BINFILE = boot.bin

ASSEMBLER = nasm
ASSEMBLER_ARGS = ${SRC}/${BOOTFILE} -o ${BIN}/${BINFILE}

QEMUSYS = qemu-system-x86_64
QEMUSYSARGS = -drive format=raw,file=${BIN}/${BINFILE}

PROJECT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
SRC_DIR := $(shell dirname $(realpath $(SRC)))
BIN_DIR  := $(shell dirname $(realpath $(BIN)))

all: generate run

generate:
	@echo making bin directory...
	@mkdir -p $(BIN)

	@echo compiling files...
	${ASSEMBLER} ${ASSEMBLER_ARGS}

	@echo finished GENERATE

run:
	@echo running ${QEMUSYS} for emulation
	${QEMUSYS} ${QEMUSYSARGS}

	@echo finished RUN

clean:
	@echo removing ${BIN} directory...
	@rm -rf ${BIN}

	@echo finished CLEAN

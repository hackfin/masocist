MASOCIST = src/vhdl/masocist-opensource

SIM_EXECUTABLE = $(MASOCIST)/sim/net_virtual_riscv

TESTSUITE = src/EXTERN/riscv-tests

TESTSUITE_REPO = https://github.com/riscv/riscv-tests

$(MASOCIST)/.config:

$(SIM_EXECUTABLE):
	$(MAKE) -C $(MASOCIST) virtual_riscv-main
	$(MAKE) -C $(MASOCIST)/sim clean all

$(TESTSUITE):
	[ -e $(dir $@) ] || mkdir $(dir $@)
	cd $(dir $@) && \
	git clone $(TESTSUITE_REPO)

install-testsuite: $(TESTSUITE)

all: $(SIM_EXECUTABLE)

run: $(SIM_EXECUTABLE)
	sh recipes/scripts/run-pyrv32.sh $(notdir $<) GHDLEX=$(GHDLEX)

test: $(SIM_EXECUTABLE)
	sh recipes/scripts/test-pyrv32.sh

clean:
	rm -f $(MASOCIST)/.config $(SIM_EXECUTABLE)

SOFTWARE = ../../sw
SIMULATION = ../../sim

ELFFILE = $(SOFTWARE)/main.elf

# WAVE_TRACE_OPTIONS = --wave=/tmp/test.ghw

$(SIMULATION)/net_virtual:
	$(MAKE) -C $(SIMULATION) clean all

run-test: $(SIMULATION)/net_virtual
	export LD_LIBRARY_PATH=$(SIMULATION):$(HOME)/lib; \
	$< 2> virtual.log $(WAVE_TRACE_OPTIONS) & \
	(MYPID=$$!; sleep 2; \
	python virtual.py $(ELFFILE); \
	echo Killing test bench with PID $$MYPID; kill $$MYPID)

all: run-test

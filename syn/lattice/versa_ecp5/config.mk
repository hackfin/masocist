

VERILOG_BB_WRAPPERS = pll_mac.v jtag_wrapper.v

IPCORES_DIR = $(FPGA_VENDOR)/$(PLATFORM)/ipcores

VERILOG_BB_WRAPPERS-y = $(VERILOG_BB_WRAPPERS:%=$(IPCORES_DIR)/%)
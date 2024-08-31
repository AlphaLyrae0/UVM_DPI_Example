include common.mk

ifdef XILINX_VIDADO
VLOG := xvlog
ELAB := xelab
SIM  := xsim
XSC  := xsc
else
VIVADO_DIR := /tools/Xilinx/Vivado/2023.1/bin
VLOG := $(VIVADO_DIR)/xvlog
ELAB := $(VIVADO_DIR)/xelab
SIM  := $(VIVADO_DIR)/xsim
XSC  := $(VIVADO_DIR)/xsc
endif

TARGET_A := ./xsim.dir/$(TOP).batch/axsim ./axsim.sh
TARGET_D := ./xsim.dir/$(TOP).debug/xsimk
TARGET_C := ./xsim.dir/work/xsc/dpi.so

.PHONY : run gui
run : $(TARGET_A) ./xsim.dir/work/xsc/dpi.so
	./axsim.sh -testplusarg UVM_TESTNAME=$(TEST_NAME)
	mv xsim.log xsim_$(TEST_NAME).log
gui : $(TARGET_D) ./xsim.dir/work/xsc/dpi.so
	$(SIM) $(TOP).debug -testplusarg UVM_TESTNAME=$(TEST_NAME) -gui

.PHONY : build_a build_d build_c
build_a : 
	make -B $(TARGET_A)
build_d : 
	make -B $(TARGET_D)
build_c :
	make -B $(TARGET_C)
#	make -B  ./dpi_lib.so

#--------------------------------------------------------------------------
INC_OPT += --include ./In_Agent
INC_OPT += --include ./Out_Agent
INC_OPT += --include ./Env
INC_OPT += --include ./Seq
INC_OPT += --include ./Test

$(TARGET_A) : $(SRC_FILES) $(INC_FILES) ./xsim.dir/work/xsc/dpi.so
	$(VLOG) -incr -L uvm -sv $(SRC_FILES) $(INC_OPT)
	$(ELAB) -incr -L uvm $(TOP) -timescale 1ns/1ps -sv_lib dpi -snapshot $(TOP).batch -standalone

$(TARGET_D) : $(SRC_FILES) $(INC_FILES) ./xsim.dir/work/xsc/dpi.so
	$(VLOG) -incr -L uvm -sv $(SRC_FILES) $(INC_OPT)
	$(ELAB) -incr -L uvm $(TOP) -timescale 1ns/1ps -sv_lib dpi -snapshot $(TOP).debug -debug all
#--------------------------------------------------------------------------
#--------------------------------------------------------------------------
$(TARGET_C) : $(C_FILES)
	$(XSC) $^
#./dpi_lib.so : ./C/dpi_get_val.cpp ./C/C_Program.cpp
#	$(XSC) -o $@ $^
#	g++ -m32 -fPIC -shared -o dpi_lib.so $^
#--------------------------------------------------------------------------

.PHONY: clean
clean :
	rm -fr xsim.dir .Xil axsim.sh dpi_lib.so
	rm -fr *.pb
	rm -rf *.log *.jou *.str
	rm -fr *.vcd *.wdb

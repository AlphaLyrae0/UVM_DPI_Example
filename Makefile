VIVADO_DIR := /tools/Xilinx/Vivado/2022.2/bin
VLOG       := $(VIVADO_DIR)/xvlog
ELAB       := $(VIVADO_DIR)/xelab
SIM        := $(VIVADO_DIR)/xsim
XSC        := $(VIVADO_DIR)/xsc

TOP      := tb_top
TARGET_A := ./xsim.dir/$(TOP).batch/axsim ./axsim.sh
TARGET_D := ./xsim.dir/$(TOP).debug/xsimk
TARGET_C := ./xsim.dir/work/xsc/dpi.so

 TEST_NAME := simple_test
#TEST_NAME := dpi_test1
#TEST_NAME := dpi_test2
#TEST_NAME := unite_test

.PHONY : run gui all
all : simple_test dpi_test1 dpi_test2 unite_test
run : $(TARGET_A) ./xsim.dir/work/xsc/dpi.so
	./axsim.sh -testplusarg UVM_TESTNAME=$(TEST_NAME)
	mv xsim.log xsim_$(TEST_NAME).log
gui : $(TARGET_D) ./xsim.dir/work/xsc/dpi.so
	$(SIM) $(TOP).debug -testplusarg UVM_TESTNAME=$(TEST_NAME) -gui

.PHONY : simple_test dpi_test1 dpi_test2 unite_test
simple_test :
	make run TEST_NAME=simple_test
dpi_test1 :
	make run TEST_NAME=dpi_test1
dpi_test2 :
	make run TEST_NAME=dpi_test2
unite_test :
	make run TEST_NAME=unite_test

.PHONY : build build_c
build : 
	make -B $(TARGET_A)
build_c :
	make -B ./xsim.dir/work/xsc/dpi.so
#	make -B  ./dpi_lib.so

#--------------------------------------------------------------------------
C_FILES += $(shell ls ./C/*.cpp)
$(TARGET_C) : $(C_FILES)
	$(XSC) $^
#./dpi_lib.so : ./C/dpi_get_val.cpp ./C/C_Program.cpp
#	$(XSC) -o $@ $^
#	g++ -m32 -fPIC -shared -o dpi_lib.so $^
#--------------------------------------------------------------------------

#--------------------------------------------------------------------------
SRC_FILES += ./DUT/dut.sv
SRC_FILES += ./TB/params_pkg.sv
SRC_FILES += ./In_Agent/in_agent_pkg.sv
SRC_FILES += ./In_Agent/in_bus_if.sv
SRC_FILES += ./Out_Agent/out_agent_pkg.sv
SRC_FILES += ./Out_Agent/out_bus_if.sv
SRC_FILES += ./Env/env_pkg.sv
SRC_FILES += ./Seq/sequence_lib_pkg.sv
SRC_FILES += ./Test/test_lib_pkg.sv
SRC_FILES += ./TB/tb_top.sv

INC_FILES +=  $(shell ls ./In_Agent/*.svh)
INC_FILES +=  $(shell ls ./Out_Agent/*.svh) 
INC_FILES +=  $(shell ls ./Env/*.svh)
INC_FILES +=  $(shell ls ./Seq/*svh)
INC_FILES +=  $(shell ls ./Test/*.svh)

INC_OPT +=  --include ./In_Agent
INC_OPT +=  --include ./Out_Agent
INC_OPT +=  --include ./Env
INC_OPT +=  --include ./Seq
INC_OPT +=  --include ./Test

$(TARGET_A) : $(SRC_FILES) $(INC_FILES) ./xsim.dir/work/xsc/dpi.so
	$(VLOG) -L uvm -sv $(SRC_FILES) $(INC_OPT)
	$(ELAB) -L uvm $(TOP) -timescale 1ns/1ps -sv_lib dpi -snapshot $(TOP).batch -standalone

$(TARGET2) : $(SRC_FILES) $(INC_FILES) ./xsim.dir/work/xsc/dpi.so
	$(VLOG) -L uvm -sv $(SRC_FILES) $(INC_OPT)
	$(ELAB) -L uvm $(TOP) -timescale 1ns/1ps -sv_lib dpi -snapshot $(TOP).debug -debug all

#--------------------------------------------------------------------------

.PHONY: clean
clean:
	rm -fr xsim.dir .Xil axsim.sh dpi_lib.so
	rm -fr *.pb
	rm -rf *.log *.jou *.str
	rm -fr *.vcd *.wdb

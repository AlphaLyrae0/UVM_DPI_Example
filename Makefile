VIVADO_DIR := /tools/Xilinx/Vivado/2022.2/bin
VLOG       := $(VIVADO_DIR)/xvlog
ELAB       := $(VIVADO_DIR)/xelab
SIM        := $(VIVADO_DIR)/xsim
XSC        := $(VIVADO_DIR)/xsc

TOP     := tb_top
WORK    := ./xsim.dir/work
TARGET  := ./xsim.dir/$(TOP).batch/axsim ./axsim.sh
TARGET2 := ./xsim.dir/$(TOP).debug/xsimk

 TEST_NAME := simple_test
#TEST_NAME := dpi_test1
#TEST_NAME := dpi_test2
#TEST_NAME := unite_test

.PHONY : run gui all
all : simple_test dpi_test1 dpi_test2 unite_test
run : $(TARGET) ./dpi_lib.so
	./axsim.sh          -testplusarg "UVM_TESTNAME=$(TEST_NAME)"
	mv xsim.log xsim_$(TEST_NAME).log
gui : $(TARGET2) ./dpi_lib.so
	$(SIM) $(TOP).debug -testplusarg "UVM_TESTNAME=$(TEST_NAME)" -gui

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
	make -B $(TARGET)
build_c :
	make -B ./dpi_lib.so

COMPILE_FILES := $(WORK)/dut.sdb
COMPILE_FILES += $(WORK)/params_pkg.sdb
COMPILE_FILES += $(WORK)/in_agent_pkg.sdb
COMPILE_FILES += $(WORK)/out_agent_pkg.sdb
COMPILE_FILES += $(WORK)/env_pkg.sdb
COMPILE_FILES += $(WORK)/sequence_lib_pkg.sdb
COMPILE_FILES += $(WORK)/test_lib_pkg.sdb
COMPILE_FILES += $(WORK)/in_bus_if.sdb
COMPILE_FILES += $(WORK)/out_bus_if.sdb
COMPILE_FILES += $(WORK)/tb_top.sdb
$(TARGET)  : $(COMPILE_FILES)
	make ./dpi_lib.so
	$(ELAB) $(TOP) -L uvm -timescale 1ns/1ps -sv_lib dpi_lib -snapshot $(TOP).batch -standalone
$(TARGET2) : $(COMPILE_FILES)
	make ./dpi_lib.so
	$(ELAB) $(TOP) -L uvm -timescale 1ns/1ps -sv_lib dpi_lib -snapshot $(TOP).debug -debug all

./dpi_lib.so : ./C/dpi_get_val.cpp ./C/C_Program.cpp
	$(XSC) -o $@ $^
#	g++ -m32 -fPIC -shared -o dpi_lib.so $^


#--------------------------------------------------------------------------
$(WORK)/dut.sdb               : ./DUT/dut.sv
	$(VLOG) -sv $< -L uvm

$(WORK)/params_pkg.sdb        : ./TB/params_pkg.sv
	$(VLOG) -sv $< -L uvm

$(WORK)/in_agent_pkg.sdb      : ./In_Agent/in_agent_pkg.sv $(shell ls ./In_Agent/*.svh)
	$(VLOG) -sv $< -L uvm --include ./In_Agent
$(WORK)/in_bus_if.sdb         : ./In_Agent/in_bus_if.sv
	$(VLOG) -sv $< -L uvm

$(WORK)/out_agent_pkg.sdb     : ./Out_Agent/out_agent_pkg.sv $(shell ls ./Out_Agent/*.svh) 
	$(VLOG) -sv $< -L uvm --include ./Out_Agent
$(WORK)/out_bus_if.sdb        : ./Out_Agent/out_bus_if.sv
	$(VLOG) -sv $< -L uvm

$(WORK)/env_pkg.sdb           : ./Env/env_pkg.sv $(shell ls ./Env/*.svh)
	make $(WORK)/in_agent_pkg.sdb
	make $(WORK)/out_agent_pkg.sdb
	$(VLOG) -sv $< -L uvm --include ./Env

$(WORK)/sequence_lib_pkg.sdb  : ./Seq/sequence_lib_pkg.sv $(shell ls ./Seq/*svh)
	make $(WORK)/in_agent_pkg.sdb
	$(VLOG) -sv $< -L uvm --include ./Seq

$(WORK)/test_lib_pkg.sdb      : ./Test/test_lib_pkg.sv $(shell ls ./Test/*.svh)
	make $(WORK)/env_pkg.sdb
	make $(WORK)/sequence_lib_pkg.sdb
	$(VLOG) -sv $< -L uvm --include ./Test

$(WORK)/tb_top.sdb            : ./TB/tb_top.sv
	make $(WORK)/params_pkg.sdb
	make $(WORK)/test_lib_pkg.sdb
	$(VLOG) -sv $< -L uvm

.PHONY: clean
clean:
	rm -fr xsim.dir .Xil axsim.sh dpi_lib.so
	rm -fr *.pb
	rm -rf *.log *.jou *.str
	rm -fr *.vcd *.wdb

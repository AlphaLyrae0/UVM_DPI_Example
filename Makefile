VIVADO_DIR := /tools/Xilinx/Vivado/2022.2/bin
VLOG       := $(VIVADO_DIR)/xvlog
ELAB       := $(VIVADO_DIR)/xelab
XSC        := $(VIVADO_DIR)/xsc

TOP    := tb_top
WORK   := ./xsim.dir/work
TARGET := $(WORK).$(TOP)/axsim ./axsim.sh

 TEST_NAME := simple_test
#TEST_NAME := dpi_test1
#TEST_NAME := dpi_test2
#TEST_NAME := unite_test

.PHONY : all
all : simple_test dpi_test1 dpi_test2 unite_test

.PHONY : run
run   : build
	./axsim.sh --testplusarg "UVM_TESTNAME=$(TEST_NAME)"

.PHONY : build
build : $(TARGET)

$(TARGET) : $(WORK)/dut.sdb
$(TARGET) : $(WORK)/params_pkg.sdb
$(TARGET) : $(WORK)/agent_pkg.sdb
$(TARGET) : $(WORK)/result_agent_pkg.sdb
$(TARGET) : $(WORK)/env_pkg.sdb
$(TARGET) : $(WORK)/sequence_lib_pkg.sdb
$(TARGET) : $(WORK)/test_lib_pkg.sdb
$(TARGET) : $(WORK)/in_bus_if.sdb
$(TARGET) : $(WORK)/out_bus_if.sdb
$(TARGET) : $(WORK)/tb_top.sdb
$(TARGET) : ./dpi_lib.so
	$(ELAB) $(TOP) -L uvm -timescale 1ns/1ps --standalone -sv_lib dpi_lib

build_c : ./dpi_lib.so
./dpi_lib.so : ./C/dpi_C_seq.cpp ./C/dpi_get_val.cpp ./C/C_Program.cpp
	$(XSC) -o $@ $^
#	g++ -m32 -fPIC -shared -o dpi_lib.so $^

simple_test :
	make run TEST_NAME=simple_test
dpi_test1 :
	make run TEST_NAME=dpi_test1
dpi_test2 :
	make run TEST_NAME=dpi_test2
unite_test :
	make run TEST_NAME=unite_test


#--------------------------------------------------------------------------
$(WORK)/dut.sdb               : ./DUT/dut.sv
	$(VLOG) -sv $< -L uvm

$(WORK)/params_pkg.sdb        : ./TB/params_pkg.sv
	$(VLOG) -sv $< -L uvm

$(WORK)/agent_pkg.sdb         : ./Agent/agent_pkg.sv
	$(VLOG) -sv $< -L uvm --include ./Agent

$(WORK)/result_agent_pkg.sdb  : ./Result_Agent/result_agent_pkg.sv
	$(VLOG) -sv $< -L uvm --include ./Result_Agent

$(WORK)/env_pkg.sdb           : $(WORK)/agent_pkg.sdb
$(WORK)/env_pkg.sdb           : $(WORK)/result_agent_pkg.sdb
$(WORK)/env_pkg.sdb           : ./Env/env_pkg.sv
	$(VLOG) -sv $< -L uvm --include ./Env

$(WORK)/sequence_lib_pkg.sdb  : $(WORK)/agent_pkg.sdb
$(WORK)/sequence_lib_pkg.sdb  : ./Seq/sequence_lib_pkg.sv
	$(VLOG) -sv $< -L uvm --include ./Seq

$(WORK)/test_lib_pkg.sdb      : $(WORK)/env_pkg.sdb
$(WORK)/test_lib_pkg.sdb      : $(WORK)/sequence_lib_pkg.sdb
$(WORK)/test_lib_pkg.sdb      : ./Test/test_lib_pkg.sv
	$(VLOG) -sv $< -L uvm --include ./Test

$(WORK)/in_bus_if.sdb         : ./TB/in_bus_if.sv
	$(VLOG) -sv $< -L uvm

$(WORK)/out_bus_if.sdb        : ./TB/out_bus_if.sv
	$(VLOG) -sv $< -L uvm

$(WORK)/tb_top.sdb            : $(WORK)/params_pkg.sdb
$(WORK)/tb_top.sdb            : $(WORK)/test_lib_pkg.sdb
$(WORK)/tb_top.sdb            : ./TB/tb_top.sv
	$(VLOG) -sv $< -L uvm

.PHONY: clean
clean:
	rm -fr xsim.dir axsim.sh dpi_lib.so
	rm -fr *.pb
	rm -rf *.log *.jou *.str
	rm -fr *.vcd *.wdb

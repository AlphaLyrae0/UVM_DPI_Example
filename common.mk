
  TOP      := tb_top

 TEST_NAME := simple_test
#TEST_NAME := dpi_test1
#TEST_NAME := dpi_test2
#TEST_NAME := unite_test

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

C_FILES += $(shell ls ./C/*.cpp)


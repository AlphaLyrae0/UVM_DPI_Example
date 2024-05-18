include common.mk

run : dpi_lib.so dsim_work/batch.so 
	dsim -sv_lib dpi_lib -uvm 1.2 -image batch +UVM_TESTNAME=$(TEST_NAME) -l dsim_$(TEST_NAME).log
dump : dpi_lib.so dsim_work/wave.so
	dsim -sv_lib dpi_lib -uvm 1.2 -image wave  +UVM_TESTNAME=$(TEST_NAME) -l dsim_$(TEST_NAME).log -waves waves.mxd

compile_batch :
	make -B dsim_work/batch.so
compile_wave :
	make -B dsim_work/wave.so
compile_c :
	make -B dpi_lib.so

view_waves :
	code -n waves.mxd
view_log :
	code dsim.log

#-------------------------------------------
INC_OPT :=  +incdir+In_Agent+Out_Agent+Env+Seq+Test
dsim_work/batch.so : $(SRC_FILES) $(INC_FILES)
	dsim -uvm 1.2 -top $(TOP) $(INC_OPT) $(SRC_FILES) -genimage batch
dsim_work/wave.so :  $(SRC_FILES) $(INC_FILES)
	dsim -uvm 1.2 -top $(TOP) $(INC_OPT) $(SRC_FILES) -genimage wave  +acc+b
#-------------------------------------------
#-------------------------------------------
dpi_lib.so : $(C_FILES)
	gcc -fPIC -shared -o $@ $^
#-------------------------------------------

clean:
	rm -rf dsim_work *.env *.db *.mxd *.vcd *.log
help :
	dsim -help


SIMULATOR := DSIM
ifdef XILINX_VIVADO
SIMULATOR := XSIM
endif
ifdef DSIM_HOME
SIMULATOR := DSIM
endif
ifdef USE_XSIM
SIMULATOR := XSIM
endif
ifdef USE_DSIM
SIMULATOR := DSIM
endif

#------------------ Metrics DSim --------------------------------------
ifeq ($(SIMULATOR),DSIM)
  include dsim.mk
endif
#----------------------------------------------------------------------

#------------------ Vivado XSIM ---------------------------------------
ifeq ($(SIMULATOR),XSIM)
  include xsim.mk
endif
#----------------------------------------------------------------------

## Manual Invoke
dsim_% :
	make -f dsim.mk $*
xsim_% :
	make -f xsim.mk $*

all : simple_test dpi_test1 dpi_test2 unite_test
simple_test :
	make run TEST_NAME=simple_test
dpi_test1   :
	make run TEST_NAME=dpi_test1
dpi_test2   :
	make run TEST_NAME=dpi_test2
unite_test :
	make run TEST_NAME=unite_test

clean_all :
	make -f dsim.mk clean
	make -f xsim.mk clean

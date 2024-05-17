
## Auto Invoke
ifdef DSIM_HOME
  include dsim.mk
else
  include xsim.mk
endif

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

clean_all : dsim_clean xsim_clean

# UVM_DPI_Example
Example of DPI-C usage in UVM with [AMD (Xilinx) Vivado Simulator](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vivado-design-tools.html) (xsim) and [Metrics DSim Desktop](https://www.metrics.ca/) (dsim)

## Usage
* To compile and run all tests<BR>
```> make all```

* To run individual test<BR>
```> make <Test Name>```

dsim is automatically used if it is installed and properly setup on your terminal. xsim is used otherwise.

You can edit dsim.mk and/or xsim.mk to accommodate your environment like tool version, path,etc.

For manual simulator selection.<BR>
```> make dsim_<command>```<BR>
```> make xsim_<command>```<BR>

Alternatively,<BR>
```> make -f dsim.mk <command>```<BR>
```> make -f xsim.mk <command>```<BR>
  
## Test Description
<dl>
<dt>simple_test</dt>  <dd>Conventional UVM sequence test without DPI-C</dd>
<dt>dpi_test1</dt>    <dd>C/C++ sequence test with DPI-C</dd>
<dt>dpi_test2</dt>    <dd>Conventional UVM sequence test which gets values from C/C++ side with DPI-C</dd>
<dt>unite_test</dt>   <dd>Executes all three sequences above in a row</dd>
</dl>

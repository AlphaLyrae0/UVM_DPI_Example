# UVM_DPI_Example
Example of DPI-C usage in UVM with [AMD (Xilinx) Vivado Simulator](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vivado-design-tools.html) (xsim) and [Metrics DSim Desktop](https://www.metrics.ca/) (dsim)

## Usage
* To compile and run all tests  
```> make all```

* To run individual test  
```> make <Test Name>```

dsim is automatically used if it is installed and properly setup on your terminal. xsim is used otherwise.

You can edit dsim.mk and/or xsim.mk to accommodate your environment like tool version, path,etc.

For manual simulator selection.  
```> make dsim_<command>```  
```> make xsim_<command>```  

Alternatively,  
```> make -f dsim.mk <command>```  
```> make -f xsim.mk <command>```  
  
## Test Description

+ simple_test  
  Conventional UVM sequence test without DPI-C
+ dpi_test1  
  C/C++ sequence test with DPI-C
+ dpi_test2  
  Conventional UVM sequence test which gets values from C/C++ side with DPI-C
+ unite_test  
  Executes all three sequences above in a row

## DPI-C import/export part

"In_Agent/in_agent_pkg.sv"

```sv
  import "DPI-C" context function void dpi_get_val(inout int Val_A, Val_B);

 //---------- For C_Program ---------------
  import "DPI-C" context task C_Program();
  export "DPI-C" sv_write = task write;
  export "DPI-C" sv_read  = task read ;
```
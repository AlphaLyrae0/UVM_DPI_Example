# UVM_DPI_Example
Example of DPI-C usage in UVM with Vivado simulator (xsim)

* To compile and run all tests<BR>
```> make all```

* To run individual test<BR>
```> make <Test Name>```
  
Test Description
<dl>
<dt>simple_test</dt>  <dd>Conventional UVM sequence test without DPI-C</dd>
<dt>dpi_test1</dt>    <dd>C/C++ sequence test with DPI-C</dd>
<dt>dpi_test2</dt>    <dd>Conventional UVM sequence test which gets values from C/C++ side with DPI-C</dd>
<dt>unite_test</dt>   <dd>Executes all three sequences above in a row</dd>
</dl>

//`timescale 1ns/10ps
module tb_top;
//timeunit 1ns;
//timeprecision 10ps;

  import uvm_pkg::*;
  import params_pkg::*;
  import test_lib_pkg::*;

  bit  clk, rstn = 0;

  in_bus_if  #(WIDTH_p) i_if(.clk, .rstn);
  out_bus_if #(WIDTH_p) o_if(.clk, .rstn);
  dut #(WIDTH_p) i_dut  ( .clk, .rstn, .en(i_if.en), .inA(i_if.Val_A), .inB(i_if.Val_B), .out(o_if.Result), .valid(o_if.valid) );

  always #10 clk = !clk;

  initial @(negedge clk) rstn = 1;

  initial begin : main_flow
  //Pass the pointer of interface to UVM test world
  //uvm_config_db #(virtual in_bus_if )::set( null , "uvm_test_top" , "i_bus_vif" , i_if);
  //uvm_config_db #(virtual out_bus_if)::set( null , "uvm_test_top" , "o_bus_vif" , o_if);
    uvm_config_db #(virtual in_bus_if )::set( uvm_root::get(), "*" , "i_bus_vif" , i_if);
    uvm_config_db #(virtual out_bus_if)::set( uvm_root::get(), "*" , "o_bus_vif" , o_if);
  //Alternative way to pass the interface pointer 
  //params_pkg::i_vif = i_if;
  //params_pkg::o_vif = o_if;
    uvm_pkg::run_test();
  end : main_flow


endmodule : tb_top

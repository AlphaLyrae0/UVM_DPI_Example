
package dpi_pkg;
  import uvm_pkg::*;
  // -dpi_lrm_context at elaboration is(was) necessary for export "DPI-C" in a pacakge 

  /*----
  /---------- For dpi_C_seq ---------------
  import "DPI-C" context task dpi_C_seq();
  export "DPI-C" task bus_drive;

  task bus_drive(input int Val_A, Val_B);
    params_pkg::i_vif.bus_drive(Val_A, Val_B);
  endtask : bus_drive
  //--------------------------------------
  ----*/

  import "DPI-C" context function void dpi_get_val(inout int Val_A, Val_B);


 //---------- For C_Program ---------------
  import "DPI-C" context task C_Program();
  export "DPI-C" sv_write = task write;
  export "DPI-C" sv_read  = task read ;

  uvm_sequencer_base  sqr;
  uvm_sequence        seq;

  task automatic DPI_seq_start(input uvm_sequencer_base sqr_, input uvm_sequence seq_);
    sqr = sqr_;
    seq = seq_;
    C_Program();
  endtask : DPI_seq_start

  import agent_pkg::*;
  task automatic write(input int A, D);
//  api_write_sequence  api_wr_seq = api_write_sequence::type_id::create("api_wr_seq");
//  api_wr_seq.Val_A = A;
//  api_wr_seq.Val_B = D;
//  api_wr_seq.start(sqr, seq);
  endtask : write

  task automatic read(input int A, output int D);
  //---- Not Implemented ----
  //api_read_sequence  api_rd_seq = api_read_sequence::type_id::create("api_rd_seq");
  //api_rd_seq.Val_A = A;
  //api_rd_seq.start(sqr, seq);
  //D = api_rd_seq.Val_R;
  endtask : read
  //--------------------------------------

endpackage : dpi_pkg




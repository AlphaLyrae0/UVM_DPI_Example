
`include "uvm_macros.svh"

package in_agent_pkg;
  import uvm_pkg::*;

  `include "in_item.svh"
  `include "api_write_sequence.svh"

  typedef uvm_sequencer#(in_item) in_sequencer ; //`include "agent_sequencer.svh"
  `include "in_driver.svh"
  `include "in_monitor.svh"
  `include "in_agent.svh"


//##############################################################################
//import "DPI-C" pure    function void dpi_get_val(inout int Val_A, Val_B);
  import "DPI-C" context function void dpi_get_val(inout int Val_A, Val_B);

 //---------- For C_Program ---------------
  import "DPI-C" context task C_Program();
  export "DPI-C" sv_write = task write;
  export "DPI-C" sv_read  = task read ;

  uvm_sequencer_base  m_sqr;
  uvm_sequence        m_seq;

  task automatic DPI_seq_start(input uvm_sequencer_base sqr_, input uvm_sequence seq_);
    m_sqr = sqr_;
    m_seq = seq_;
    C_Program();
  endtask

  api_write_sequence  api_wr_seq;
  task automatic write(input int A, D);
  //api_write_sequence  api_wr_seq = api_write_sequence::type_id::create("api_wr_seq");
    api_wr_seq = api_write_sequence::type_id::create("api_wr_seq");
    api_wr_seq.Val_A = A;
    api_wr_seq.Val_B = D;
    api_wr_seq.start(m_sqr, m_seq);
  endtask

  task automatic read(input int A, output int D);
  //---- Not Implemented ----
  //api_read_sequence  api_rd_seq = api_read_sequence::type_id::create("api_rd_seq");
  //api_rd_seq.Val_A = A;
  //api_rd_seq.start(m_sqr, m_seq);
  //D = api_rd_seq.Val_R;
  endtask
  //--------------------------------------

//##############################################################################

endpackage

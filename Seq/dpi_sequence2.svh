//class dpi_sequence2 extends sequence_base;
class dpi_sequence2 extends uvm_sequence;
  `uvm_object_utils(dpi_sequence2)
 
  function new(string name="");
    super.new(name);
  endfunction

  api_write_sequence  api_wr_seq;

  virtual task body();
    `uvm_info(this.get_type_name(), {"\n--------------- ", this.get_type_name(), " started !!! -----------------"}, UVM_LOW)

    // Agent Bus Drive DPI Sequence
    api_wr_seq = api_write_sequence::type_id::create("api_wr_seq");
    dpi_get_val(.Val_A(api_wr_seq.Val_A), .Val_B(api_wr_seq.Val_B));
  //api_wr_seq.start(this.m_sequencer, this);
    api_wr_seq.start(this.get_sequencer(), this);

  endtask

endclass

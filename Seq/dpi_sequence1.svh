//class dpi_sequence1 extends sequence_base;
class dpi_sequence1 extends uvm_sequence;
  `uvm_object_utils(dpi_sequence1)
 
  function new(string name="");
    super.new(name);
  endfunction

  virtual task body();
    `uvm_info(this.get_type_name(), {"\n--------------- ", this.get_type_name(), " started !!! -----------------"}, UVM_LOW)

    // Agent API sequece creation in dpi_pkg
  //DPI_seq_start(m_sequencer, this);
    DPI_seq_start(this.get_sequencer(), this);

  endtask

endclass

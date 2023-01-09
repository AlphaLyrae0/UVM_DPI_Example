//class unite_sequence extends sequence_base;
class unite_sequence extends uvm_sequence;
  `uvm_object_utils(unite_sequence)
 
  function new(string name="unite_sequence");
    super.new(name);
  endfunction

  simple_sequence   spl_seq;
  dpi_sequence1     dpi_seq1;
  dpi_sequence2     dpi_seq2;

  virtual task body();
    `uvm_info(this.get_type_name(), {"\n--------------- ", this.get_type_name(), " started !!! -----------------"}, UVM_LOW)

    spl_seq  = simple_sequence ::type_id::create("spl_seq");
    dpi_seq1 = dpi_sequence1   ::type_id::create("dpi_seq1");
    dpi_seq2 = dpi_sequence2   ::type_id::create("dpi_seq2");

  //spl_seq .start( .sequencer( this.m_sequencer     ), .parent_sequence( this ) );
  //dpi_seq1.start( .sequencer( this.m_sequencer     ), .parent_sequence( this ) );
  //dpi_seq2.start( .sequencer( this.m_sequencer     ), .parent_sequence( this ) );
    spl_seq .start( .sequencer( this.get_sequencer() ), .parent_sequence( this ) );
    dpi_seq1.start( .sequencer( this.get_sequencer() ), .parent_sequence( this ) );
    dpi_seq2.start( .sequencer( this.get_sequencer() ), .parent_sequence( this ) );

  endtask

endclass

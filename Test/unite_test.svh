
class unite_test extends test_base;

  // UVM Factory Registration Macro
  `uvm_component_utils(unite_test)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  //sequence_base::type_id::set_inst_override( unite_sequence::get_type(), "top_sequence" );  // Override by instance
  //sequence_base::type_id::set_type_override( unite_sequence::get_type() );                  // Override by type
  endfunction

  /*----------*/
  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    begin : UNITE_SEQUENCE
      unite_sequence  top_sequence = unite_sequence::type_id::create("top_sequence");
      top_sequence.start( .sequencer(this.m_sequencer), .parent_sequence(null) ); // Target Sequence
    end   : UNITE_SEQUENCE

    begin : DPI_START_SEQUENCE
      dpi_start_sequence  extra_sequence = dpi_start_sequence::type_id::create("extra_sequence");
      extra_sequence.start( .sequencer(this.m_sequencer), .parent_sequence(null) ); // Target Sequence
    end   : DPI_START_SEQUENCE

    DPI_SEQUENCE_START : 
    DPI_seq_start(this.m_sequencer, null);

    phase.drop_objection(this);
  endtask
  /*---------*/

endclass


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
    unite_sequence  top_sequence;
    phase.raise_objection(this);
    top_sequence = unite_sequence::type_id::create("top_sequence");
    top_sequence.start( .sequencer(this.m_sequencer), .parent_sequence(null) ); // Target Sequence
    phase.drop_objection(this);
  endtask
  /*---------*/

endclass

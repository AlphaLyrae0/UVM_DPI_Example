
class test_base extends uvm_test;

//UVM Factory Registration Macro
  `uvm_component_utils(test_base)
   
  // The environment class
  env  m_env;
  // Configuration objects
//env_config m_env_cfg;

  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  // Configure and build componets
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    m_env = env::type_id::create("m_env", this);
  endfunction

  uvm_sequencer_base  m_sequencer;

  virtual function void connect_phase(uvm_phase phase);
  //if( !uvm_config_db #(virtual bus_if)::get(this, "" , "bus_vif", myif) ) $display("Error") //`uvm_error(...)
    m_sequencer = m_env.m_sequencer;
  endfunction : connect_phase


  virtual function void end_of_elaboration_phase (uvm_phase phase);
  //uvm_pkg::uvm_top.enable_print_topology = 1;
  //super.end_of_elaboration_phase(phase);
    uvm_pkg::uvm_top.print_topology();
    begin
      uvm_factory factory = uvm_factory::get();
      factory.print();
    end
  endfunction

/*--------------
//uvm_sequence_base   top_sequence;
//uvm_sequence        top_sequence;
  sequence_base       top_sequence;

  virtual task run_phase(uvm_phase phase);
  //super.run_phase(phase);
    phase.raise_objection(this);
  //top_sequence = uvm_sequence_base::type_id::create("top_sequence");
  //top_sequence = uvm_sequence::type_id::create("top_sequence");
    top_sequence = sequence_base::type_id::create("top_sequence");
    top_sequence.start(. sequencer(this.m_sequencer), .parent_sequence(null) );     // Target Sequence
    phase.drop_objection(this);
  endtask
--------------*/

  virtual function void start_of_simulation_phase(uvm_phase phase);
    `uvm_info("TEST", $sformatf("\n\
####################################\n\
  TESTNAME : %s \n\
####################################"
      , this.get_type_name() ), UVM_MEDIUM)
  endfunction

  virtual function void final_phase(uvm_phase phase);
    `uvm_info("TEST", $sformatf("\n\
 ------------------------------------\n\
|  Thank you for running me!! Bye.\n\
|    -- %s \n\
 ------------------------------------"
      , this.get_type_name() ), UVM_MEDIUM)
  endfunction

endclass



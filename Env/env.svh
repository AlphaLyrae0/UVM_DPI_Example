
class env extends uvm_env;

  `uvm_component_utils(env)

  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction

  uvm_sequencer_base  m_sequencer;

  agent         agnt     ;
  result_agent  rslt_agnt;
  scoreboard    scrbd    ;

  virtual function void build_phase(uvm_phase phase);
    super.build();
    agnt       = agent       ::type_id::create("agnt"     , this);
    rslt_agnt  = result_agent::type_id::create("rslt_agnt", this);
    scrbd      = scoreboard  ::type_id::create("scrbd"    , this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    m_sequencer   = agnt.seqr; 

    agnt     .mon_ap.connect(scrbd.in_port );
    rslt_agnt.mon_ap.connect(scrbd.out_port);
     
  endfunction

endclass





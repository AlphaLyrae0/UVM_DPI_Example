
class env extends uvm_env;

  `uvm_component_utils(env)

  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction

  uvm_sequencer_base  m_sequencer;

  in_agent      i_agnt;
  out_agent     o_agnt;
  scoreboard    m_sb  ;

  virtual function void build_phase(uvm_phase phase);
    super.build();
    i_agnt = in_agent  ::type_id::create("i_agnt", this);
    o_agnt = out_agent ::type_id::create("o_agnt", this);
    m_sb   = scoreboard::type_id::create("m_sb"  , this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    m_sequencer = i_agnt.m_sqr; 

    i_agnt.mon_ap.connect(m_sb.in_port );
    o_agnt.mon_ap.connect(m_sb.out_port);
     
  endfunction

endclass





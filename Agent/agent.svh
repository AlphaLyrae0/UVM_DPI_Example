
class agent extends uvm_agent;
  `uvm_component_utils(agent)

  function new (string name, uvm_component parent);
    super.new(name,parent);
  endfunction

  uvm_analysis_port #(agent_item) mon_ap;

  agent_sequencer  seqr;
  agent_monitor    mntr;
  agent_driver     drvr;

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    mon_ap = new("mon_ap", this);
    seqr   = agent_sequencer::type_id::create("seqr", this);
    drvr   = agent_driver   ::type_id::create("drvr", this);
    mntr   = agent_monitor  ::type_id::create("mntr", this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    mntr.myif = params_pkg::i_vif;
    drvr.myif = params_pkg::i_vif;
    drvr.seq_item_port.connect(seqr.seq_item_export);
    mntr.ap.connect(mon_ap);
  endfunction

endclass


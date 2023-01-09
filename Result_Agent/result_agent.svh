
class result_agent extends uvm_agent;
  `uvm_component_utils(result_agent)

  function new (string name, uvm_component parent);
    super.new(name,parent);
  endfunction:new 

  uvm_analysis_port #(result_item) mon_ap;

  result_monitor    mntr;

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    this.mon_ap = new("mon_ap", this);
    mntr = result_monitor  ::type_id::create("mntr", this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    mntr.myif = params_pkg::o_vif;
    mntr.ap.connect(mon_ap);
  endfunction

endclass



class out_agent extends uvm_agent;
  `uvm_component_utils(out_agent)

  function new (string name, uvm_component parent);
    super.new(name,parent);
  endfunction

  uvm_analysis_port #(out_item) mon_ap;

  out_monitor    m_monitor;

  virtual out_bus_if v_if;

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    this.mon_ap = new("mon_ap", this);
    m_monitor = out_monitor::type_id::create("m_monitor", this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    m_monitor.myif = this.v_if; //params_pkg::o_vif;
    m_monitor.ap.connect(mon_ap);
  endfunction

endclass


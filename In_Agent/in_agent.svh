
class in_agent extends uvm_agent;
  `uvm_component_utils(in_agent)

  function new (string name, uvm_component parent);
    super.new(name,parent);
  endfunction

  uvm_analysis_port #(in_item) mon_ap;

  in_sequencer  m_sqr;
  in_monitor    m_mon;
  in_driver     m_drv;

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    mon_ap = new("mon_ap", this);
    m_sqr  = in_sequencer::type_id::create("m_sqr", this);
    m_drv  = in_driver   ::type_id::create("m_drv", this);
    m_mon  = in_monitor  ::type_id::create("m_mon", this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    m_mon.v_if = params_pkg::i_vif;
    m_drv.v_if = params_pkg::i_vif;
    m_drv.seq_item_port.connect(m_sqr.seq_item_export);
    m_mon.ap.connect(mon_ap);
  endfunction

endclass


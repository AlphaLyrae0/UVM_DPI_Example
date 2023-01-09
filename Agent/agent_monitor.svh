
class agent_monitor extends uvm_monitor;
  `uvm_component_utils(agent_monitor)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual in_bus_if myif;

  uvm_analysis_port #(agent_item) ap;

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    this.ap = new("ap", this);
  endfunction
 
//function void connect_phase(uvm_phase phase);
//  super.connect_phase(phase);
//  myif = params_pkg::v_myif;
//endfunction: connect_phase

  task run_phase(uvm_phase phase);
  //super.run_phase(phase);
    @(posedge myif.rstn);
    forever @(posedge myif.clk) check_bus();
  endtask

  agent_item tr;
  virtual function void check_bus();
    if(myif.en) begin
      tr = agent_item::type_id::create("tr");
      this.begin_tr(tr);
      tr.Val_A = this.myif.Val_A;
      tr.Val_B = this.myif.Val_B;
    //`uvm_info("Monitor", $sformatf("Val_A  : %4d ", this.myif.Val_A ), UVM_MEDIUM)
    //`uvm_info("Monitor", $sformatf("Val_B  : %4d ", this.myif.Val_B ), UVM_MEDIUM)
    //`uvm_info("Monitor", $sformatf("Result : %4d ", this.myif.Result), UVM_MEDIUM)
    //`uvm_info("Monitor", $sformatf("Val_A  : %4d ", tr.Val_A ), UVM_MEDIUM)
    //`uvm_info("Monitor", $sformatf("Val_A  : %4d ", tr.Val_B ), UVM_MEDIUM)
    //`uvm_info("Monitor", tr.convert2string(), UVM_LOW)
    //`uvm_info("Monitor", "Transaction Printing...", UVM_LOW)
    //tr.print();
      `uvm_info("Monitor", {"Transaction Printing...\n", tr.sprint()}, UVM_MEDIUM)
      ap.write(tr);
      this.end_tr(tr);
    end
  endfunction

endclass




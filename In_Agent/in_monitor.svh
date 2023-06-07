
class in_monitor extends uvm_monitor;
  `uvm_component_utils(in_monitor)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual in_bus_if v_if;

  uvm_analysis_port #(in_item) ap;

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    this.ap = new("ap", this);
  endfunction
 
//function void connect_phase(uvm_phase phase);
//  super.connect_phase(phase);
//  v_if = params_pkg::v_myif;
//endfunction: connect_phase

  task run_phase(uvm_phase phase);
  //super.run_phase(phase);
    @(posedge v_if.rstn);
    forever @(posedge v_if.clk) check_bus();
  endtask

  in_item tr;
  virtual function void check_bus();
    if(v_if.en) begin
      tr = in_item::type_id::create("tr");
      this.begin_tr(tr);
      tr.Val_A = this.v_if.Val_A;
      tr.Val_B = this.v_if.Val_B;
    //`uvm_info("Monitor", $sformatf("Val_A  : %4d ", this.v_if.Val_A ), UVM_MEDIUM)
    //`uvm_info("Monitor", $sformatf("Val_B  : %4d ", this.v_if.Val_B ), UVM_MEDIUM)
    //`uvm_info("Monitor", $sformatf("Result : %4d ", this.v_if.Result), UVM_MEDIUM)
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




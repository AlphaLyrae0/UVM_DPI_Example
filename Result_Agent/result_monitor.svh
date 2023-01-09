
class result_monitor extends uvm_monitor;
  `uvm_component_utils(result_monitor)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction: new

  virtual out_bus_if myif;

  uvm_analysis_port #(result_item) ap;

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    this.ap = new("ap", this);
  endfunction
 
//function void connect_phase(uvm_phase phase);
//  super.connect_phase(phase);
//  myif = params_pkg::v_myif;
//endfunction: connect_phase

  virtual task run_phase(uvm_phase phase);
  //super.run_phase(phase);
    forever @(posedge myif.clk) if(myif.rstn) check_bus();
  endtask: run_phase

  result_item tr;

  virtual function check_bus();
    if(myif.valid) begin
      tr = result_item::type_id::create("tr");
      this.begin_tr(tr);
      tr.Val = this.myif.Result;
      `uvm_info("Result Monitor", $sformatf("Result : %4d ", this.myif.Result), UVM_MEDIUM)
    //`uvm_info("Monitor", tr.convert2string(), UVM_LOW)
    //`uvm_info("Monitor", "Transaction Printing...", UVM_LOW)
    //tr.print();
      `uvm_info("Result Monitor", {"Transaction Printing...\n", tr.sprint()}, UVM_MEDIUM)
      ap.write(tr);
      this.end_tr(tr);
    end
  endfunction

endclass




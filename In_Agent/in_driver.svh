
class in_driver extends uvm_driver #(in_item);
  `uvm_component_utils(in_driver)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual in_bus_if v_if;

//function void build_phase(uvm_phase phase);
//  super.build_phase(phase);
//endfunction: build_phase
 
//function void connect_phase(uvm_phase phase);
//  super.connect_phase(phase);
//  v_if = params_pkg::v_myif;
//endfunction: connect_phase

  virtual task run_phase(uvm_phase phase);
  //super.run_phase(phase);
    v_if.Val_A = '0;
    v_if.Val_B = '0;;
    v_if.en    = 'b0;
    @(posedge v_if.rstn);
    forever this.drive_bus();
  endtask

  virtual task drive_bus();
    this.seq_item_port.get_next_item(this.req);
  //v_if.bus_drive(req.Val_A, req.Val_B);
    @(negedge v_if.clk);
    v_if.Val_A = this.req.Val_A;
    v_if.Val_B = this.req.Val_B;
    v_if.en    = 'b1;
    @(negedge v_if.clk);
    v_if.en    = 'b0;
    this.seq_item_port.item_done();
  endtask

endclass






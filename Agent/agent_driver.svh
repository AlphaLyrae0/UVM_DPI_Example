
class agent_driver extends uvm_driver #(agent_item);
  `uvm_component_utils(agent_driver)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual in_bus_if myif;

//function void build_phase(uvm_phase phase);
//  super.build_phase(phase);
//endfunction: build_phase
 
//function void connect_phase(uvm_phase phase);
//  super.connect_phase(phase);
//  myif = params_pkg::v_myif;
//endfunction: connect_phase

  virtual task run_phase(uvm_phase phase);
  //super.run_phase(phase);
    myif.Val_A = '0;
    myif.Val_B = '0;;
    myif.en    = 'b0;
    @(posedge myif.rstn);
    forever this.drive_bus();
  endtask

  virtual task drive_bus();
    this.seq_item_port.get_next_item(this.req);
  //myif.bus_drive(req.Val_A, req.Val_B);
    @(negedge myif.clk);
    myif.Val_A = this.req.Val_A;
    myif.Val_B = this.req.Val_B;
    myif.en    = 'b1;
    @(negedge myif.clk);
    myif.en    = 'b0;
    this.seq_item_port.item_done();
  endtask

endclass






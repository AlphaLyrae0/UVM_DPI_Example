
class api_write_sequence extends uvm_sequence #(agent_item);
 
  function new(string name="");
    super.new(name);
  endfunction

  rand int Val_A, Val_B;

  `uvm_object_utils(api_write_sequence)

  virtual task body();
    this.req = agent_item::type_id::create("req");
    this.start_item(this.req);
    this.req.Val_A = this.Val_A;
    this.req.Val_B = this.Val_B;
    this.finish_item(this.req);
  endtask

endclass

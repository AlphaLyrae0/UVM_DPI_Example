//class simple_sequence extends sequence_base;
class simple_sequence extends uvm_sequence;
  `uvm_object_utils(simple_sequence)
 
  function new(string name="");
    super.new(name);
  endfunction

  api_write_sequence  api_wr_seq;

  int unsigned Val_A = 120, Val_B = 20;
  virtual task body();
    `uvm_info(this.get_type_name(), {"\n--------------- ", this.get_type_name(), " started !!! -----------------"}, UVM_LOW)

    api_wr_seq = api_write_sequence::type_id::create("api_wr_seq");
    api_wr_seq.Val_A = Val_A;
    api_wr_seq.Val_B = Val_B;
  //api_wr_seq.start(this.m_sequencer, this);
    api_wr_seq.start(this.get_sequencer(), this);
    repeat(5) begin
      Val_A += 20;
      Val_B += 2;
      api_wr_seq = api_write_sequence::type_id::create("api_wr_seq");
      api_wr_seq.Val_A = Val_A;
      api_wr_seq.Val_B = Val_B;
    //api_wr_seq.start(this.m_sequencer, this);
      api_wr_seq.start(this.get_sequencer(), this);
    end

  endtask

endclass

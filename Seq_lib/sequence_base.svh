
class sequence_base extends uvm_sequence;
  `uvm_object_utils(sequence_base)
 
  function new(string name="");
    super.new(name);
  endfunction

endclass

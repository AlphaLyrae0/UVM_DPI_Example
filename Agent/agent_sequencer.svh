
class agent_sequencer extends uvm_sequencer # (agent_item);
  `uvm_component_utils(agent_sequencer)

  function new (string name, uvm_component parent);
    super.new(name,parent);
  endfunction

endclass


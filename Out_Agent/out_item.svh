
class out_item extends uvm_sequence_item;

  function new(string name="");
    super.new(name);
  endfunction

  rand  int Val;

//`uvm_object_utils(out_item) 
  `uvm_object_utils_begin(out_item) 
    `uvm_field_int (Val, UVM_ALL_ON | UVM_DEC)
  `uvm_object_utils_end

  virtual function string convert2string();
     string msg = super.convert2string();
     msg = {msg, 
               "\n  -----------------------\n",
       $sformatf("    Val  : %d\n", this.Val),
                 "  -----------------------" 
     };
     return msg;
  endfunction

// Macro is used instead
//function void do_print(uvm_printer printer);
//  super.do_print(printer); 
//  if(printer.knobs.sprint == 0)
//    $display(this.convert2string());
//  else
//    printer.m_string = this.convert2string();
//endfunction: do_print

// Macro is used instead
//function void do_copy(uvm_object rhs = null);
//  super.do_copy(rhs);
//  begin
//    out_item to;
//    $cast(to,rhs);
//    to.Val = this.Val;
//  end
//endfunction: do_copy

// Field Macro is used insted
//virtual function void do_record(uvm_recorder recorder);
//  super.do_record(recorder);
//  `uvm_record_field( "Val", Val)
//endfunction

endclass


class in_item extends uvm_sequence_item;

  function new(string name="");
    super.new(name);
  endfunction

  typedef enum {READ, WRITE } kind_t;
  rand kind_t kind=WRITE;
  rand int    Val_A, Val_B;

//`uvm_object_utils(in_item) 
  `uvm_object_utils_begin(in_item) 
    `uvm_field_enum(kind_t, kind, UVM_ALL_ON)
    `uvm_field_int (Val_A, UVM_ALL_ON | UVM_DEC)
    `uvm_field_int (Val_B, UVM_ALL_ON | UVM_DEC)
  `uvm_object_utils_end
//

  virtual function string convert2string();
     string msg; // = super.convert2string();
     msg = {msg, 
               "\n  -----------------------\n",
       $sformatf("    Val_A  : %d\n", this.Val_A),
       $sformatf("    Val_B  : %d\n", this.Val_B),
                 "  -----------------------" 
     };
     return msg;
  endfunction

// Field Macro is used insted
//virtual function void do_print(uvm_printer printer);
//  super.do_print(printer); 
//  if(printer.knobs.sprint == 0)
//    $display(this.convert2string());
//  else
//    printer.m_string = this.convert2string();
//endfunction: do_print

// Field Macro is used insted
//virtual function void do_copy(uvm_object rhs = null);
//  super.do_copy(rhs);
//  begin
//    in_item to;
//    $cast(to,rhs);
//    to.Val_A = this.Val_A;
//    to.Val_B = this.Val_B;
//  end
//endfunction: do_copy

// Field Macro is used insted
//virtual function void do_record(uvm_recorder recorder);
//  super.do_record(recorder);
//  `uvm_record_field( "kind" , kind.name() )
//  `uvm_record_field( "Val_A", Val_A       )
//  `uvm_record_field( "Val_B", Val_B       )
//endfunction

endclass

 
class scoreboard  extends uvm_scoreboard;
  `uvm_component_utils(scoreboard)

  uvm_analysis_export#( in_item)              in_port;
  uvm_analysis_imp   #(out_item, scoreboard) out_port;

  uvm_tlm_analysis_fifo#(in_item) q_in;
 
  int m_matches, m_mismatches, m_unexpected;
 
  function new( string name , uvm_component parent) ;
    super.new( name , parent );
    m_matches    = 0;
    m_mismatches = 0;
    m_unexpected = 0;
  endfunction
 
  virtual function void build_phase( uvm_phase phase );
    in_port   = new("in_port" , this);
    out_port  = new("out_port", this);
    q_in      = new("q_in"    , this);
  endfunction

  virtual function void connect_phase( uvm_phase phase );
    in_port.connect(q_in.analysis_export);
  endfunction
 
  virtual function void write(out_item txn);    
    in_item  tr_in;

    if ( q_in.try_get(tr_in) )
      compare_trans(tr_in, txn, create_exp(tr_in) );
    else begin
    //`uvm_error( "Unexpected DUT output : ", txn.convert2string() )
      `uvm_error( "Unexpected DUT output : ", txn.sprint() )
      m_unexpected++;
      return;
    end

  endfunction

  protected virtual function void compare_trans(in_item txn_in, out_item tr_dut, tr_exp);
    if (!tr_exp.compare(tr_dut)) begin
    //`uvm_error( "Comparator Mismatch", $sformatf("\nDUT Input : %s \nDUT Output : %s \nExpected : %s ", txn_in.convert2string(), tr_dut.convert2string(), tr_exp.convert2string() ) )
      `uvm_error( "Comparator Mismatch", $sformatf("\nDUT Input : \n%s \nDUT Output : \n%s \nExpected : \n%s ", txn_in.sprint(), tr_dut.sprint(), tr_exp.sprint() ) )
      m_mismatches++;
    end
    else begin
    //`uvm_info( "Comparator Match"    , $sformatf("\nDUT Input : %s \nDUT Output : %s \nExpected : %s ", txn_in.convert2string(), tr_dut.convert2string(), tr_exp.convert2string() ), UVM_MEDIUM )
      `uvm_info( "Comparator Match"    , $sformatf("\nDUT Input : \n%s \nDUT Output : \n%s \nExpected : \n%s ", txn_in.sprint(), tr_dut.sprint(), tr_exp.sprint() ), UVM_MEDIUM )
      m_matches++;
    end
  endfunction

  virtual function out_item create_exp(in_item txn);    
    out_item exp = out_item::type_id::create("exp");
    exp.Val = $unsigned(params_pkg::WIDTH_p'(txn.Val_A + txn.Val_B));
    return(exp);
  endfunction
 
  virtual function void report_phase( uvm_phase phase );
    `uvm_info("Inorder Comparator", $sformatf("Matches:    %0d", m_matches   ), UVM_LOW);
    `uvm_info("Inorder Comparator", $sformatf("Mismatches: %0d", m_mismatches), UVM_LOW);
  endfunction
 
endclass

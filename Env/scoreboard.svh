`uvm_analysis_imp_decl(_in)
`uvm_analysis_imp_decl(_out)
 
//class scoreboard #(type Tin = uvm_sequence_item, type Tout = uvm_sequence_item) extends uvm_scoreboard;
//  `uvm_component_param_utils(scoreboard)
class scoreboard  extends uvm_scoreboard;
  `uvm_component_utils(scoreboard)

  uvm_analysis_imp_in   #(agent_item , scoreboard)  in_port;
  uvm_analysis_imp_out  #(result_item, scoreboard) out_port;
 
  int m_matches, m_mismatches, m_unexpected;
  agent_item  q_in[$];
 
  function new( string name , uvm_component parent) ;
    super.new( name , parent );
    m_matches    = 0;
    m_mismatches = 0;
    m_unexpected = 0;
  endfunction
 
  virtual function void build_phase( uvm_phase phase );
    in_port   = new("in_port" , this);
    out_port  = new("out_port", this);
  endfunction
 
  virtual function void write_in(agent_item txn);    
    q_in.push_back(txn);
  endfunction

  virtual function void write_out(result_item txn);    
    if (q_in.size() > 0) compare_trans(txn);
    else begin
    //`uvm_error( "Unexpected DUT output : ", txn.convert2string() )
      `uvm_error( "Unexpected DUT output : ", txn.sprint() )
      m_unexpected++;
    end
  endfunction

  protected virtual function void compare_trans(result_item tr_dut);
    agent_item  txn_in;
    result_item tr_exp;
    txn_in = q_in.pop_front();
    tr_exp = create_exp( txn_in );
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

  virtual function result_item create_exp(agent_item txn);    
    result_item exp = result_item::type_id::create("exp");
    exp.Val = $unsigned(params_pkg::WIDTH_p'(txn.Val_A + txn.Val_B));
    return(exp);
  endfunction
 
  virtual function void report_phase( uvm_phase phase );
    `uvm_info("Inorder Comparator", $sformatf("Matches:    %0d", m_matches   ), UVM_LOW);
    `uvm_info("Inorder Comparator", $sformatf("Mismatches: %0d", m_mismatches), UVM_LOW);
  endfunction
 
endclass

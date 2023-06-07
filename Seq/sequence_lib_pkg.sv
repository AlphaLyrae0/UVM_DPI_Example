
`include "uvm_macros.svh"

package sequence_lib_pkg;
  import uvm_pkg::*;
  import in_agent_pkg::*;
//import dpi_pkg::*;
//import params_pkg::*;
  `include "simple_sequence.svh"
  `include "dpi_sequence1.svh"
  `include "dpi_sequence2.svh"
  `include "unite_sequence.svh"
endpackage : sequence_lib_pkg

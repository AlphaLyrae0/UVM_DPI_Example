
interface out_bus_if #(parameter WIDTH_p = 8) ( input clk, rstn );
  logic[WIDTH_p-1:0] Result;
  logic              valid;
endinterface


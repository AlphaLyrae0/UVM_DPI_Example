
interface in_bus_if #(parameter WIDTH_p = 8) ( input clk, rstn );
  logic[WIDTH_p-1:0] Val_A, Val_B;
  logic              en;
endinterface : in_bus_if


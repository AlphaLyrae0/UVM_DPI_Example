
module dut #(parameter WIDTH_p = 8)
( 
  input  logic              clk, rstn,
  input  logic              en,
  input  logic[WIDTH_p-1:0] inA, inB,
  output logic[WIDTH_p-1:0] out,
  output logic              valid
 );

  always_ff@(posedge clk or negedge rstn)
    if(!rstn) begin
      out   <= '0;
      valid <= 'b0;
    end
    else if (en) begin
      out   <= inA + inB;
      valid <= 1'b1;
    end
    else begin
      valid <= 1'b0;
    end

endmodule : dut

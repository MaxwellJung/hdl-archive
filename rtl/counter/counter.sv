`timescale 1ns / 1ps
`default_nettype none

module counter #(
  parameter int InitialCount = 0,
  parameter int MaxCount = (1 << 32) - 1,
  localparam int NumBits = $clog2(MaxCount + 1)
) (
  input wire clk_i,
  input wire rst_i,
  input wire en_i,

  output logic [NumBits-1:0] count_o
);

  always_ff @(posedge clk_i) begin
    if (rst_i) begin
      count_o <= InitialCount;
    end else if (en_i) begin
      count_o <= (count_o == MaxCount) ? InitialCount : count_o + 1;
    end
  end

endmodule
`default_nettype wire

`timescale 1ns / 1ps
`default_nettype none

module fixed_delay #(
  parameter int Delay = 4,
  parameter int DWidth = 32
) (
  input wire clk_in,
  input wire rst_in,
  input wire en_in,

  input  logic [DWidth-1:0] data_in,
  output logic [DWidth-1:0] data_out
);

  logic [Delay-1:0][DWidth-1:0] pipeline;

  always_ff @(posedge clk_in) begin
    if (rst_in) begin
      pipeline <= '0;
    end else if (en_in) begin
      pipeline <= {pipeline[Delay-2:0], data_in};
    end
  end

  assign data_out = pipeline[Delay-1];

endmodule
`default_nettype wire

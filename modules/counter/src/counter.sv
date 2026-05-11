`timescale 1ns / 1ps

`default_nettype none
module counter #(
    parameter int NumBits = 8
) (
    input logic clk,
    input logic reset,
    input logic enable,

    output logic [NumBits-1:0] count
);

    always_ff @(posedge clk) begin
        if (reset) begin
            count <= 0;
        end else if (enable) begin
            count <= count + 1;
        end
    end

endmodule
`default_nettype wire

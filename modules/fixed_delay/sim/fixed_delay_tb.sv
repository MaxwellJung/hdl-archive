`timescale 1ns / 1ps

// Import the C library function
import sim_lib_pkg::output_dir;

module fixed_delay_tb;
  localparam int Delay = 4;
  localparam int DWidth = 32;
  localparam int ClkPeriod = 10ns; // 100 MHz clock

  // UUT Instantiation.
  logic clk;
  logic rst;
  logic en;

  logic [DWidth-1:0] data_in;
  logic [DWidth-1:0] data_out;

  fixed_delay #(
    .Delay  (Delay),
    .DWidth (DWidth)
  ) uut (
    .clk_in (clk),
    .rst_in (rst),
    .en_in  (en),

    .data_in (data_in),
    .data_out (data_out)
  );

  initial clk = '0;
  always begin
    #(ClkPeriod / 2.0) clk = ~clk;
  end

  always @(posedge clk) begin
    if (rst) begin
      data_in <= '0;
    end else begin
      data_in <= $urandom;
    end
  end

  initial begin
    $dumpfile({output_dir, "/fixed_delay_tb.vcd"});
    $dumpvars(0, fixed_delay_tb);
  end

  always begin
    // hold rst for 10 clock cycles.
    @(posedge clk);
    rst <= '1;
    repeat(10) @(posedge clk);
    rst <= '0;

    // wait 5 clock cycles.
    repeat(5) @(posedge clk);

    en <= '1;

    // wait 20 clock cycles.
    repeat(20) @(posedge clk);
    $finish;
  end

endmodule

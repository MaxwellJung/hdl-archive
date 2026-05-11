`timescale 1ns / 1ps

module counter_tb ();
    localparam int NumBits = 8;
    localparam int ClkPeriod = 10; // 100 MHz clock

    logic clk;
    logic reset;
    logic enable;
    wire [NumBits-1:0] count;

    counter #(
        .NumBits(NumBits)
    ) counter_inst (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .count(count)
    );

    initial clk = 0;
    always #(ClkPeriod / 2.0)
        clk = ~clk;

    initial begin
        $dumpfile("counter_tb.vcd");
        $dumpvars(0, counter_tb);
    end

    initial begin
        // pause counter
        enable = 0;

        // hold reset for 10 clock cycles
        reset = 1;
        repeat (10) @(posedge clk);
        reset = 0;


        // start counter for 50 ns
        repeat (10) @(posedge clk);
        enable = 1;
        repeat (5) @(posedge clk);
        enable = 0;

        assert (count != 0)
            else $error("Counter should not be zero after reset is deasserted");

        // resume counter for 50 ns
        repeat (10) @(posedge clk);
        enable = 1;
        repeat (5) @(posedge clk);
        enable = 0;

        // hold reset for 50 ns
        reset = 1;
        repeat (5) @(posedge clk);
        reset = 0;

        repeat (20) @(posedge clk);
        $finish;
    end

endmodule

`timescale 1ns / 1ps

module counter_tb ();
    localparam NUM_BITS = 8;
    localparam CLK_PERIOD = 2;

    logic clk;
    logic reset;
    logic enable;
    wire [NUM_BITS-1:0] count;
    
    counter counter_inst (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .count(count)
    );

    initial clk = 0;
    always #(CLK_PERIOD / 2.0)
        clk = ~clk;

    initial begin
        $dumpfile("counter_tb.vcd");
        $dumpvars(0, counter_tb);
        // pause counter
        enable <= 0;

        // hold reset for 10 ns
        reset <= 1;
        #10
        reset <= 0;

        // start counter for 50 ns
        #10
        enable <= 1;
        #50
        enable <= 0;

        // resume counter for 50 ns
        #10
        enable <= 1;
        #50
        enable <= 0;

        // hold reset for 50 ns
        reset <= 1;
        #50
        reset <= 0;

        #20 $finish;
    end

endmodule

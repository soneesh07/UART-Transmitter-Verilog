`timescale 1ns/1ns

module uart_tx_tb;

    reg clk;
    reg reset;
    reg start;
    reg [7:0] data_in;

    wire tx;
    wire busy;
    wire done;

    uart_tx uut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .data_in(data_in),
        .tx(tx),
        .busy(busy),
        .done(done)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test Stimulus
    initial begin

        // Initialize inputs
        reset   = 1;
        start   = 0;
        data_in = 8'b10100101;

        // Hold reset
        #20;
        reset = 0;

        // Wait a little
        #20;

        // Start transmission
        start = 1;
        #10;
        start = 0;

        // Wait for transmission to complete
        wait(done);

        #20;

        $display("Transmission Completed Successfully");

        $finish;
    end

    initial begin
    $monitor("t=%0t current=%0d bit_count=%0d baud_done=%b bit_done=%b tx=%b",
    $time,
    uut.current,
    uut.btc.bit_count,
    uut.baud_done,
    uut.bit_done,
    tx
);
    end
    initial begin
        $dumpfile("uart_tx.vcd");
        $dumpvars(0, uart_tx_tb);
    end

endmodule
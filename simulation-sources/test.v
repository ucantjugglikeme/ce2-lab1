`timescale 1ns / 1ps


module test();

reg clk, R_I, reset;
reg [31:0] dataIn;
wire [31:0] dataOut;
wire R_O;

initial begin
    clk = 0;
    reset = 1;
    R_I = 0;
    dataIn = 0;
    #20;
end

always #10 clk <= ~clk;

fsm #(.n(8)) fsm0(
    .clk(clk),
    .dataIn(dataIn),
    .R_I(R_I),
    .reset(reset),
    .dataOut(dataOut),
    .R_O(R_O)
);

endmodule

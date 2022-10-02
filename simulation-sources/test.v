`timescale 1ns / 1ps


module test();

reg clk, R_I, reset;
reg [31:0] dataIn;
wire [31:0] dataOut;
wire R_O;
// to delete
/*wire [2:0] st;
wire [3:0] addr;
wire [31:0] cur_el1;
wire [31:0] cur_el2;
wire [31:0] cur_el3;
wire [31:0] cur_el4;
wire [31:0] cur_el5;
wire [31:0] cur_el6;
wire [31:0] cur_el7;
wire [31:0] cur_el8;*/

initial begin
    clk = 0;
    reset = 1;
    R_I = 0;
    dataIn = 0;
    #30;
    
    reset = 0;
    R_I <= 1;
    #40;
    
    dataIn <= 32'h00F0CB01;
    #40;
    
    dataIn <= 32'h00AACB21;
    #40;
    
    dataIn <= 32'h00309631;
    #40;
    
    dataIn <= 32'h1DFEEB01;
    #40;
    
    dataIn <= 32'h5C2AEBC1;
    #40;
    
    dataIn <= 32'h02F2CB31;
    #40;
    
    dataIn <= 32'h0000ACAB;
    #40;
    
    dataIn <= 32'hFADECB01;
    #40;
    
    R_I <= 0;
    dataIn <= 0;
    #320;
    //$finish;
end

always #10 clk <= ~clk;

fsm #(.n(8)) fsm0(
    .clk(clk),
    .dataIn(dataIn),
    .R_I(R_I),
    .reset(reset),
    .dataOut(dataOut),
    .R_O(R_O)
    //to delete
    /*,.st(st),
    .addr(addr),
    .cur_el1(cur_el1),
    .cur_el2(cur_el2),
    .cur_el3(cur_el3),
    .cur_el4(cur_el4),
    .cur_el5(cur_el5),
    .cur_el6(cur_el6),
    .cur_el7(cur_el7),
    .cur_el8(cur_el8)*/
);

endmodule

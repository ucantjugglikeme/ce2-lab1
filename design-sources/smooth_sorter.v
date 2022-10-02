module smooth_sorter#(
    parameter n = 256
)(
    input clk,
    input [31:0] dataIn,
    input [n:1] addr,
    input wr,
    input rst,
    input sel,
    output [31:0] dataOut
    // to delete
    /*,output [31:0] cur_el1,
    output [31:0] cur_el2,
    output [31:0] cur_el3,
    output [31:0] cur_el4,
    output [31:0] cur_el5,
    output [31:0] cur_el6,
    output [31:0] cur_el7,
    output [31:0] cur_el8*/
);

reg [31:0] REG_ARR [n:1];
integer i;

// to delete
/*assign cur_el1 = REG_ARR[1];
assign cur_el2 = REG_ARR[2];
assign cur_el3 = REG_ARR[3];
assign cur_el4 = REG_ARR[4];
assign cur_el5 = REG_ARR[5];
assign cur_el6 = REG_ARR[6];
assign cur_el7 = REG_ARR[7];
assign cur_el8 = REG_ARR[8];*/

initial
    for (i = 1; i <= n; i = i + 1)
        REG_ARR[i] <= 0;

always @(posedge clk) begin
    if (rst)
        for (i = 1; i <= n; i = i + 1)
            REG_ARR[i] <= 0;
    else if (wr)
        REG_ARR[addr] <= dataIn;
    else
        REG_ARR[addr] <= REG_ARR[addr];
end

assign dataOut = (sel & ~wr) ? REG_ARR[addr] : 0;

endmodule

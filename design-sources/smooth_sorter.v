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
);

reg [31:0] REG_ARR [n:1];
integer i;

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

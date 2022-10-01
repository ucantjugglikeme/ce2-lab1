module fsm #(
    parameter n = 256
)(
    input clk, 
    input [31:0] dataIn,
    input R_I,
    input reset,
    output [31:0] dataOut,
    output reg R_O
);

reg [2:0] state;
reg wr;
reg sel;
integer i;

smooth_sorter #(.n(n)) sorter(
    .clk(clk), .dataIn(dataIn), .addr(i), 
    .wr(wr), .rst(reset), .sel(sel), 
    .dataOut(dataOut)
);

initial begin
    state = 3'b000;
    R_O = 0;
    wr = 0;
    sel = 0;
    i = 0;
end

always @(posedge clk) begin
    if (reset)
        state <= 3'b000;
    else
        case(state)
            3'b000: begin
                wr <= 0;
                sel <= 0;
                i <= 1;
            end
            3'b001: begin
                if (R_I)
                    wr <= 1;
                    state <= 3'b010;
            end
            3'b010: begin
                wr <= 0;
                i <= i + 1;
                if (i <= n)
                    state <= 3'b001;
                else begin
                    i <= 1;
                    state <= 3'b011;
                end
            end
            3'b011: begin
                sel <= 1;
                state <= 3'b100;
            end
            3'b100: begin
                sel <= 0;
                i <= i + 1;
                if (i <= n)
                    state <= 3'b011;
                else
                    state <= 3'b000;               
            end
        endcase
end

always @(posedge clk) begin
    case (state)
        3'b000: R_O <= 0;
        3'b011: R_O <= 1;
    endcase 
end

endmodule

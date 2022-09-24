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

//reg [31:0] REG_ARR [n-1:0];

reg [1:0] state;
reg [31:0] cur_input;
wire [31:0] cur_output;
integer i;

smooth_sorter #(.n(n)) sorter(.clk(clk), .dataIn(cur_input), .is_input(R_I), .i(i), .dataOut(cur_output));

initial begin
    state = 2'b00;
    cur_input = 32'h00000000;
    R_O = 0;
    i = 0;
end

always @(posedge clk) begin
    if (reset)
        state <= 2'b00;
    else
        case(state)
            2'b00: begin
                cur_input <= 32'h00000000;
                i <= 0;
                state <= 2'b01;
            end
            2'b01: begin
                if (R_I) begin
                    if (i < n) begin
                        cur_input <= dataIn;
                        i <= i + 1;
                    end
                    else begin
                        i <= 0;
                        state <= 2'b10;
                    end
                end
            end
            2'b10: begin
                if (i < n)
                    i <= i + 1;
                else begin
                    state <= 2'b00;
                end
            end
        endcase
end

always @(posedge clk) begin
    case (state)
        2'b00: R_O <= 0;
        2'b10: R_O <= 1;
    endcase 
end

endmodule

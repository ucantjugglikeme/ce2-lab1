module fsm #(
    parameter n = 256
)(
    input clk, 
    input [31:0] dataIn,
    input R_I,
    input reset,
    output [31:0] dataOut,
    output reg R_O
    // to delete
    /*,output [2:0] st,
    output [3:0] addr,
    output [31:0] cur_el1,
    output [31:0] cur_el2,
    output [31:0] cur_el3,
    output [31:0] cur_el4,
    output [31:0] cur_el5,
    output [31:0] cur_el6,
    output [31:0] cur_el7,
    output [31:0] cur_el8*/
);

reg [2:0] state;
reg wr;
reg sel;
integer i;

// to delete
assign st = state;
assign addr = i[3:0];

smooth_sorter #(.n(n)) sorter(
    .clk(clk), .dataIn(dataIn), .addr(i), 
    .wr(wr), .rst(reset), .sel(sel), 
    .dataOut(dataOut)
    // to delete
    /*,.cur_el1(cur_el1),
    .cur_el2(cur_el2),
    .cur_el3(cur_el3),
    .cur_el4(cur_el4),
    .cur_el5(cur_el5),
    .cur_el6(cur_el6),
    .cur_el7(cur_el7),
    .cur_el8(cur_el8)*/
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
            3'b000: begin  // Начальная установка
                wr <= 0;
                sel <= 0;
                i <= 1;
                state <= 3'b001;
            end
            3'b001: begin       // Предварительные настройки для записи, 
                if (R_I) begin  // если осуществляется ввод
                    wr <= 1;
                    state <= 3'b010;
                end
            end
            3'b010: begin       // Ввод в ячейку массива, переход к следующему элементу.
                i <= i + 1;     // Если массив заполнен, перейти к следующему состоянию,
                wr <= 0;        // иначе заново настроить ввод следующей ячейки
                if (i <= n) begin
                    state <= 3'b001;
                end
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
                i <= i + 1;
                sel <= 0;
                if (i < n)
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
        3'b100: R_O <= 0;
    endcase 
end

endmodule

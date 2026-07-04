module pc_flop (
    input clk,rst,
    input [31:0] pcnext,
    output reg [31:0] pc
);
    always@(posedge clk or posedge rst) 
        pc <= rst ? 32'd0 : pcnext;
endmodule

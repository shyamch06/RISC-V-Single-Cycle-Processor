module alu_mux (
    input [31:0] writedata,immext,
    input alusrc,
    output [31:0] srcB
);
    assign srcB = alusrc ? immext : writedata;
endmodule

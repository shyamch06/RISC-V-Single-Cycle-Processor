module pc_target (
    input [31:0] pc,immext,
    output [31:0] pctarget
);
    assign pctarget = pc + immext;
endmodule
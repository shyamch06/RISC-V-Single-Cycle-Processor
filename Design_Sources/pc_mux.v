module pc_mux (
    input pcsrc,
    input [31:0] pcplus4,pctarget,
    output [31:0] pcnext
);
    assign pcnext = pcsrc ? pctarget : pcplus4 ;
endmodule
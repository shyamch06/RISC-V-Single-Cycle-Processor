module result_mux (
    input [1:0] resultsrc,
    input [31:0] aluresult,readdata,pcplus4,immext,
    output [31:0] result
);
    reg [31:0] regresult;
    always @(*) begin
        case (resultsrc)
            2'b00 : regresult = aluresult;
            2'b01 : regresult = readdata;
            2'b10 : regresult = pcplus4;
            2'b11 : regresult = immext;
            default: regresult = 32'd0;
        endcase
    end
    assign result = regresult;
endmodule
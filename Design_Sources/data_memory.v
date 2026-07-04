module data_memory (
    input clk,
    input memwrite, // write or not
    input [31:0] aluresult,
    input [31:0] wd, // write data
    output [31:0] rd // read data
);
    reg [31:0] datamem [127:0] ;
    integer i;
    initial begin
        for (i = 0;i < 128 ;i = i+1) begin
            datamem[i] = 32'b0;
        end
    end
    always @(posedge clk) begin
        if(memwrite)
            datamem[aluresult[8:2]] <= wd;
    end

    assign rd = datamem[aluresult[8:2]];
endmodule
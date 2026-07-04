module reg_file (
    input clk,regwrite,
    input [4:0] rs1,rs2,rd,
    input [31:0] wd3,
    output [31:0] rd1,rd2,x1
);
    reg [31:0] register_mem [31:0];
    integer i;
    initial begin
        for (i = 0;i < 32 ;i= i+1) begin
            register_mem[i] = 32'd0;
        end
    end
    always @(posedge clk)  begin
        if(regwrite && rd != 0)
            register_mem[rd] <= wd3; 
    end
    assign rd1 = (rs1 != 0) ? register_mem[rs1] : 32'b0;
    assign rd2 = (rs2 != 0) ? register_mem[rs2] : 32'b0;
    assign x1 = register_mem[1];
endmodule
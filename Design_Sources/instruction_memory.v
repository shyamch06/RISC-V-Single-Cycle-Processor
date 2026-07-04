module instruction_memory (
    input [31:0] pc,
    output [31:0] instr
);
    reg [31:0] mem [127:0];
    initial begin
        $readmemh("program.mem",mem);
    end
    assign instr = mem[pc >> 2];
endmodule


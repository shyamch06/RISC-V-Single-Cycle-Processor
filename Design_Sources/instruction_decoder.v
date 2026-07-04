module instruction_decoder (
    input [31:0] instr,
    output [4:0] rs1, rs2, rd,
    output [6:0] opcode, func7,
    output [2:0] func3
);
    assign rs1 = instr[19:15];
    assign rs2 = instr[24:20];
    assign rd = instr[11:7];
    assign opcode = instr[6:0];
    assign func3 = instr[14:12];
    assign func7 = instr[31:25];
    
endmodule
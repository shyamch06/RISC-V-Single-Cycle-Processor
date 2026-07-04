module controlunit(
    input [6:0] opcode,
    input [6:0] func7,
    input [2:0] func3,
    input zero,

    output  pcsrc,
    output  [1:0] resultsrc,
    output  memwrite,
    output  [5:0] alucntrl,
    output  [2:0] immsrc,
    output  alusrc,
    output  regwrite,
    output  memread,
    output  memtoreg,
    output  jump
);


wire [2:0] aluop;
wire branch;

reg pcsrc_condition;

always @(*)
begin
    case (func3)

        3'b000: pcsrc_condition = branch & zero;   //beq
        3'b001: pcsrc_condition = branch & ~zero;  //bne
        default: pcsrc_condition = 0; 
    endcase
end

assign pcsrc = pcsrc_condition | jump;

main_decoder md(
    .opcode(opcode),

    .branch(branch),
    .resultsrc(resultsrc),
    .memwrite(memwrite),
    .alusrc(alusrc),
    .immsrc(immsrc),
    .regwrite(regwrite),
    .aluop(aluop),
    .jump(jump),
    .memread(memread),
    .memtoreg(memtoreg)
);

alu_decoder ad(
    .aluop(aluop),
    .func3(func3),
    .func7(func7),

    .alucntrl(alucntrl)
);

endmodule
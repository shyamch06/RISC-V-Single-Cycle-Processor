module processor (
    input clk,reset,
    output [31:0] result,fib_value
);

wire [31:0] pcnext,pc,pcplus4,pctarget,immext,instr,rd1,rd2,x1,srcB,aluresult,readdata;
wire pcsrc,regwrite,zero,memwrite,alusrc,memread,memtoreg,jump;
wire [4:0] rs1,rs2,rd;
wire [6:0] opcode, func7;
wire [2:0] func3,immsrc;
wire [1:0] resultsrc;
wire [5:0] alucntrl;

pc_flop pcflop(clk,reset,pcnext,pc);
pc_mux pcmux(pcsrc,pcplus4,pctarget,pcnext);
pc_plus4 pcp4(pc,pcplus4);
pc_target pctgt(pc,immext,pctarget);
instruction_memory instrmem(pc,instr);
instruction_decoder instrdecode(instr,rs1,rs2,rd,opcode,func7,func3);
reg_file rfile(clk,regwrite,rs1,rs2,rd,result,rd1,rd2,x1);

assign fib_value = rfile.register_mem[1];

extend immex(instr,immsrc,immext);
controlunit cunit(opcode,func7,func3,zero,pcsrc,resultsrc,memwrite,alucntrl,immsrc,alusrc,regwrite,memread,memtoreg,jump);
alu_mux alumux(rd2,immext,alusrc,srcB);
alu alu(rd1,srcB,alucntrl,aluresult,zero);
data_memory dmem(clk,memwrite,aluresult,rd2,readdata);
result_mux resultmux(resultsrc,aluresult,readdata,pcplus4,immext,result);


endmodule

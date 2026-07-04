module main_decoder (
    input [6:0] opcode,
    output reg branch, // branch = 1 : branch taken
    output reg [1:0] resultsrc, // 00: aluresult, 01: memorydata, 10: pc+4, 11: upper immediate
    output reg memwrite, // write to memory
    output reg alusrc, // alusrc = 0: from register, alusrc = 1: from immediate
    output reg [2:0] immsrc, // type of immediate
    output reg regwrite,
    output reg [2:0] aluop,
    output reg jump,
    output reg memread,
    output reg memtoreg
);
always @(*) begin
    case (opcode)
        //R-type
       7'b0110011:begin
                  branch     = 0;
                  resultsrc  = 2'b00;
                  memwrite   = 0;
                  alusrc     = 0;
                  immsrc     = 3'b000;
                  regwrite   = 1;
                  aluop      = 3'b001;
                  jump       = 0;
                  memread    = 0;
                  memtoreg   = 0;
                 // pcsrc      = 0;
       end
       
        // I-type
        7'b0010011:begin
                  branch     = 0;
                  resultsrc  = 2'b00;
                  memwrite   = 0;
                  alusrc     = 1;
                  immsrc     = 3'b000;
                  regwrite   = 1;
                  aluop      = 3'b010;
                  jump       = 0;
                  memread    = 0;
                  memtoreg   = 0;
                  //pcsrc      = 0;
       end

       // Load
        7'b0000011:begin
                  branch     = 0;
                  resultsrc  = 2'b01;
                  memwrite   = 0;
                  alusrc     = 1;
                  immsrc     = 3'b000;
                  regwrite   = 1;
                  aluop      = 3'b000;
                  jump       = 0;
                  memread    = 1;
                  memtoreg   = 1;
                 // pcsrc      = 0;
       end

       //Store
        7'b0100011:begin
                  branch     = 0;
                  resultsrc  = 2'b00;
                  memwrite   = 1;
                  alusrc     = 1;
                  immsrc     = 3'b001;
                  regwrite   = 0;
                  aluop      = 3'b000;
                  jump       = 0;
                  memread    = 0;
                  memtoreg   = 0;
                 // pcsrc      = 0;
       end

       //Branch
        7'b1100011:begin
                  branch     = 1;
                  resultsrc  = 2'b00;
                  memwrite   = 0;
                  alusrc     = 0;
                  immsrc     = 3'b010;
                  regwrite   = 0;
                  aluop      = 3'b011;
                  jump       = 0;
                  memread    = 0;
                  memtoreg   = 0;
                  //pcsrc      = branch;
       end

       //JAL
        7'b1101111:begin
                  branch     = 0;
                  resultsrc  = 2'b10;
                  memwrite   = 0;
                  alusrc     = 0;
                  immsrc     = 3'b100;
                  regwrite   = 1;
                  aluop      = 3'b100;
                  jump       = 1;
                  memread    = 0;
                  memtoreg   = 0;
                 // pcsrc      = 1;
       end

       //JALR
        7'b1100111:begin
                  branch     = 0;
                  resultsrc  = 2'b10;
                  memwrite   = 0;
                  alusrc     = 1;
                  immsrc     = 3'b000;
                  regwrite   = 1;
                  aluop      = 3'b100;
                  jump       = 1;
                  memread    = 0;
                  memtoreg   = 0;
                 // pcsrc      = 1;
       end

       //LUI
        7'b0110111:begin
                  branch     = 0;
                  resultsrc  = 2'b11;
                  memwrite   = 0;
                  alusrc     = 1;
                  immsrc     = 3'b011;
                  regwrite   = 1;
                  aluop      = 3'b101;
                  jump       = 0;
                  memread    = 0;
                  memtoreg   = 0;
                 // pcsrc      = 0;
       end

       //AUIPC
        7'b0010111:begin
                  branch     = 0;
                  resultsrc  = 2'b00;
                  memwrite   = 0;
                  alusrc     = 1;
                  immsrc     = 3'b011;
                  regwrite   = 1;
                  aluop      = 3'b110;
                  jump       = 0;
                  memread    = 0;
                  memtoreg   = 0;
                  //pcsrc      = 0;
       end

        default:begin
                  branch     = 0;
                  resultsrc  = 2'b00;
                  memwrite   = 0;
                  alusrc     = 0;
                  immsrc     = 3'b000;
                  regwrite   = 0;
                  aluop      = 3'b000;
                  jump       = 0;
                  memread    = 0;
                  memtoreg   = 0;
                 // pcsrc      = 0;
       end
  
    endcase
end
endmodule
module alu_decoder (
    input [2:0] aluop, func3,
    input [6:0] func7,
    output reg [5:0] alucntrl
);
    always @(*)
begin
    case(aluop)
    
    //LOAD,STORE
    3'b000 : alucntrl = 25; 
    //ADD    same for all lb,lh,lw,lhu,lbu  and also for sw,sh,sb
    
    //R TYPE
    3'b001:begin
          case({func7,func3}) 
          
          {7'b0000000,3'b000}: alucntrl = 0; //ADD
          {7'b0100000,3'b000}: alucntrl = 1; //SUB
          {7'b0000000,3'b111}: alucntrl = 2; //AND
          {7'b0000000,3'b110}: alucntrl = 3; //OR
          {7'b0000000,3'b100}: alucntrl = 4; //XOR
          {7'b0000000,3'b001}: alucntrl = 5; //SLL
          {7'b0000000,3'b101}: alucntrl = 6; //SRL
          {7'b0100000,3'b101}: alucntrl = 7; //SRA
          {7'b0000000,3'b010}: alucntrl = 8; //SLT
          {7'b0000000,3'b011}: alucntrl = 9; //SLTU

          endcase
        end
    
    //I TYPE
    3'b010:begin

          case(func3)

          3'b000: alucntrl = 10;   //ADDI
          3'b111: alucntrl = 11;  //ANDI
          3'b110: alucntrl = 12;  //ORI
          3'b100: alucntrl = 13;  //XORI
          3'b001: alucntrl = 14;  //SLLI
          3'b101: begin
                  if(func7==7'b0000000)
                    alucntrl = 15;  //SRLI
                  else
                    alucntrl = 16;  //SRAI
                  end
          3'b010: alucntrl = 17;  //SLTI
          3'b011: alucntrl = 18;  //SLTIU


          endcase
          end 

    //BRANCH
    3'b011:begin

            case(func3)
            3'b000: alucntrl = 19; //BEQ
            3'b001: alucntrl = 20; //BNE
            3'b100: alucntrl = 21; //BLT
            3'b101: alucntrl = 22; //BGE
            3'b110: alucntrl = 23; //BLTU
            3'b111: alucntrl = 24; //BGEU

            endcase
            end

    //JAL,JALR
    3'b100: alucntrl = 27;

    //LUI
    3'b101: alucntrl = 29;

    //AUIPC
    3'b110: alucntrl = 30;
    
    
    endcase
end
endmodule
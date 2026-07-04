module alu (
    input [31:0] a,b,
    input [5:0] aluctrl,
    output reg[31:0] aluresult,
    output zero
);
    always @(*) begin
    case (aluctrl)

     //R TYPE
    0: aluresult = a + b;   //add
    1: aluresult = a - b;   //sub
    2: aluresult = a & b;   //and
    3: aluresult = a | b;   //or
    4: aluresult = a ^ b;   //xor
    5: aluresult = a << b[4:0];  //sll
    6: aluresult = a >> b[4:0];  //srl
    7: aluresult = $signed(a) >>> b[4:0];  //sra
    8: aluresult = ($signed(a) < $signed(b))?1:0;   //slt
    9: aluresult = (a < b)?1:0;   //sltu      
    
    //I TYPE
    10: aluresult = a + b;  //addi
    11: aluresult = a & b;   //andi
    12: aluresult = a | b;   //ori
    13: aluresult = a ^ b;   //xori
    14: aluresult = a << b[4:0];  //slli
    15: aluresult = a >> b[4:0];  //srli
    16: aluresult = $signed(a) >>> b[4:0];  //srai
    17: aluresult = ($signed(a) < $signed(b))?1:0;   //slti
    18: aluresult = (a < b)?1:0;   //sltiu

    //BRANCH
    19: aluresult = (a - b); // beq
    20: aluresult = (a - b); // bne
    21: aluresult = ($signed(a) < $signed(b));    //blt
    22: aluresult = ($signed(a) >= $signed(b));     //bge
    23: aluresult = (a < b);    //bltu
    24: aluresult = (a >= b);   //bgeu

    //LOAD
    25: aluresult = a + b;    //lw

    //STORE
    26: aluresult = a + b;     //sw

    //J TYPE
    27: aluresult = a + 4;    //jal
    28: aluresult = (a + b) & ~32'b1;   //jalr

    //LUI
    29: aluresult = b;     
    
    //AUIPC
    30: aluresult = a + b;     //auipc

    default: aluresult = 0;
 
    endcase
    end

    assign zero = (aluresult == 0);
endmodule

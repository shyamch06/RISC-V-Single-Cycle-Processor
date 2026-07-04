module topmodule (
    input clk,reset,
    output [6:0] seg,
    output [3:0] an
);

wire clkout;
wire [31:0] result,fib_value;
wire [15:0] bcd;
wire [3:0] digit;

clkdivider clkdiv(clk,reset, clkout);
processor risc(clkout,reset,result,fib_value);
bcdconvertor bcdconv(fib_value,bcd);
display disp(an,digit,bcd[3:0],bcd[7:4],bcd[11:8],bcd[15:12],clk);
sevenseg seg7(digit,seg);
endmodule
module aluCtrl(exeCtrl, offset, outToAlu);

input [3:0] exeCtrl;
input [31:0] offset;

output [3:0] outToAlu;
reg [3:0] outToAlu;

wire [1:0] aluOp = exeCtrl[2:1];
wire [5:0] functionCode = offset[5:0];
/*
aluOp:
0 => lw/sw
1 => beq
3 => bne (egtehad sha5sy XDD)
2 => determined by functionCode
*/

initial outToAlu=0;


always @(aluOp or functionCode)
begin

case(aluOp)
0: outToAlu=0;
1: outToAlu=7;
3: outToAlu=8;
2: case(functionCode) 
6'b100000: outToAlu= 1;	//add
6'b100010: outToAlu= 2;	//sub
6'b100100: outToAlu= 3;	//and
6'b100101: outToAlu= 4;	//or
6'b000000: outToAlu= 5;	//sll
6'b000010: outToAlu= 6;	//srl
6'b101010: outToAlu= 9;	//slt
default: outToAlu=4'b1111;
endcase
default: outToAlu=4'b1111;
endcase



end




endmodule

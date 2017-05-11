module controlUnit(opCode,regDst,branch,memRead,memToReg,aluOp,memWrite,aluSrc,regWrite);

input [5:0] opCode;

output regDst,branch,memRead,memToReg,memWrite,aluSrc,regWrite;
output [1:0] aluOp;
reg regDst,branch,memRead,memToReg,memWrite,aluSrc,regWrite;
reg [1:0] aluOp;

initial 
begin
regDst=0;
branch=0;
memRead=0;
memToReg=0;
memWrite=0;
aluSrc=0;
regWrite=0;
aluOp=0;
end

always @(opCode)
begin
case(opCode)
6'b000000:{regDst,aluSrc,memToReg,regWrite,memRead,memWrite,branch,aluOp}=9'b100100010;	//R-format
6'b100011:{regDst,aluSrc,memToReg,regWrite,memRead,memWrite,branch,aluOp}=9'b011110000;	//lw
6'b101011:{regDst,aluSrc,memToReg,regWrite,memRead,memWrite,branch,aluOp}=9'b010001000;	//sw
6'b000100:{regDst,aluSrc,memToReg,regWrite,memRead,memWrite,branch,aluOp}=9'b000000101;	//beq
6'b000101:{regDst,aluSrc,memToReg,regWrite,memRead,memWrite,branch,aluOp}=9'b000000111;	//bne
endcase
end

endmodule
`include "clock.v"
`include "pcCircuit.v"
`include "adder32.v"
`include "adder4.v"
`include "InstructionMemory.v"
`include "IFID.v"
`include "IDEX.v"
`include "controlUnit.v"
`include "registerFile.v"
`include "signExtend.v"
`include "aluCtrl.v"
`include "mux32_1.v"
`include "alu.v"
`include "EXEMEM.v"
`include "Data.v"
`include "MEMWB.v"
`include "forwarding.v"
`include "muxi.v"

module main();
wire [31:0] pcPlus4,pcCurrent,instruction,branchAddressEXMEM,pcIFID,instructionIFID,
dataOut1,dataOut2,RFDATA,thirtyTwoBit,pcIDEX,regData1IDEX,regData2IDEX,aluMuxOut,
branchedPC,aluResult,aluResultEXMEM,memoryDataEXMEM,read_data,aluResultMEMWB,memoryRead,
offsetIDEX,aluMuxOut1,aluMuxOut2;
wire [1:0] aluOp,wbCtrlEXMEM,wbCtrlIDEX,ForwardA,ForwardB;
wire [2:0] memCtrlIDEX,memCtrlEXMEM;
wire [3:0] outToAlu;
wire [4:0] rs , rt , rd,rsIFID,rtIFID,rdIFID,rdMEMWB,rdIDEX,rtIDEX,rsIDEX,rdEXMEM,offsetIDEXs,destinationRegister;
wire [5:0] opCode,opCodeIFID;
wire [15:0] constant,constantIFID;
wire regDst,branch,memRead,memToReg,memWrite,aluSrc,regWrite,regWriteWB,br,zero,pcSrc,clk;



// check order of concaaaat droryy
clock Clock (clk);

pcCircuit PcCircuit(pcCurrent, pcSrc ,clk, branchAddressEXMEM, pcPlus4);

adder4 Adder4(pcPlus4,pcCurrent);

InstructionMemory instructionMemory(instruction,opCode,rs,rt,rd,constant,pcCurrent);

IFID ifid(pcIFID,instructionIFID,{pcPlus4,instruction},clk,opCodeIFID,rsIFID,rtIFID,rdIFID,constantIFID);

controlUnit ControlUnit(opCodeIFID,regDst,branch,memRead,memToReg,aluOp,memWrite,aluSrc,regWrite);

registerFile RegisterFile(rsIFID,rtIFID,rdMEMWB,RFDATA,regWriteWB,dataOut1,dataOut2,clk); //@@@

signExtend SignExtend(constantIFID,thirtyTwoBit);

IDEX idex(pcIDEX ,regData1IDEX,regData2IDEX,offsetIDEX,offsetIDEXs,rdIDEX,rtIDEX,rsIDEX,
wbCtrlIDEX,memCtrlIDEX,exeCtrlIDEX3,exeCtrlIDEX2,exeCtrlIDEX1,exeCtrlIDEX0,{rsIFID,pcIFID,dataOut1,dataOut2,
thirtyTwoBit,rdIFID,rtIFID,regWrite,memToReg,memRead,memWrite,branch,
aluSrc,aluOp,regDst},clk);

aluCtrl AluCtrl({exeCtrlIDEX3,exeCtrlIDEX2,exeCtrlIDEX1,exeCtrlIDEX0}, offsetIDEX, outToAlu); 

wire aluSrcIDEX = exeCtrlIDEX3;

mux32_1 Mux1(aluMuxOut,regData2IDEX,offsetIDEX,aluSrcIDEX);

muxi Muxi1(aluMuxOut1,aluMuxOut,RFDATA,aluResultEXMEM,ForwardB);

muxi Muxi2(aluMuxOut2,regData1IDEX,RFDATA,aluResultEXMEM,ForwardA);

wire [4:0] shiftAmount = offsetIDEXs;

alu Alu(aluResult,zero,aluMuxOut2,aluMuxOut1,shiftAmount,outToAlu);

wire [31:0] shiftedByTwo = offsetIDEX<<2;

adder32 Adder32(branchedPC,pcIDEX,shiftedByTwo);

wire regDestIDEX = exeCtrlIDEX0;

assign destinationRegister = (regDestIDEX==0)? rdIDEX:rtIDEX;

EXMEM exem(branchAddressEXMEM,aluResultEXMEM,memoryDataEXMEM,rdEXMEM,wbCtrlEXMEM,
wbregwriteEXMEM,wbmemtoregEXMEM,memCtrlEXMEM,br,zeroEXMEM,
{branchedPC,aluResult,regData2IDEX, destinationRegister, wbCtrlIDEX, memCtrlIDEX,zero},clk); 

wire branchEXMEM = br;

assign pcSrc = zeroEXMEM && branchEXMEM;

data Data(clk,aluResultEXMEM,memoryDataEXMEM,memCtrlEXMEM,read_data);

MEMWB memwb(aluResultMEMWB,memoryRead,rdMEMWB, regWriteWB,memToRegWB,{aluResultEXMEM,read_data,rdEXMEM,wbCtrlEXMEM}, clk);

mux32_1 Mux2(RFDATA,aluResultMEMWB,memoryRead,memToRegWB);

forwarding Forwarding(wbregwriteEXMEM,regWriteWB,rdEXMEM,rdMEMWB,rsIDEX,rtIDEX,ForwardA,ForwardB);
initial
begin
$monitor("%b %b %b %b %b %b %b %b %b %b",instructionMemory.Instruction_Memory[32'b 00000000000000000000000000001010],rsIFID,rtIFID,rdMEMWB,RFDATA,regWriteWB,ForwardA,ForwardB,instruction,rs,rt);
end
endmodule

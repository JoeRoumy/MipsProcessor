module EXMEM(output reg [31:0] branchAddress,alu,writeToMemory,
output reg [4:0] rd,output reg [1:0] wb,output reg regwrite,output reg memtoreg,output reg [2:0] mem,output reg br,
output reg zero,input [106:0] exeMem,input clk);

initial
begin
branchAddress=0;
alu=0;
writeToMemory=0;
rd=0;
wb=0;
regwrite=0;
memtoreg=0;
mem=0;
br=0;
zero=0;
end

always @(posedge clk)
begin
branchAddress <= exeMem[106:75];
alu <= exeMem[74:43];
writeToMemory <= exeMem[42:11];
rd <= exeMem[10:6];
wb <= exeMem[5:4];
regwrite <= exeMem[5];
memtoreg <= exeMem[4];
mem <= exeMem[3:1];
br <= exeMem[1];
zero <= exeMem[0];
end
endmodule
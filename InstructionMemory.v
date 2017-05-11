module InstructionMemory(instruction,opCode,rs,rt,rd,constant,address);
input [31:0] address;
output reg[5:0] opCode;
output reg[4:0] rs,rt,rd;
output reg[15:0]constant;
output reg[31:0]instruction;
reg [31:0]Instruction_Memory[67108864:0];
reg [31:0]temp;

initial 
begin
opCode=0;
rs=0;
rt=0;
rd=0;
constant=0;
instruction=0;
Instruction_Memory[32'b 00000000000000000000000000001010]=32'b00000001010010010100100000100100; // and $t1,$t2,$t1 
Instruction_Memory[32'b 00000000000000000000000000001011]=32'd0; // lw $t3,0($s1) 
Instruction_Memory[32'b 00000000000000000000000000001100]=32'b00000001010010110101100000100100; //and $t3,$t2,$t3
Instruction_Memory[32'b 00000000000000000000000000001101]=32'b00000001001010110101100000100100; // lw $t3,0($s1) 
Instruction_Memory[32'b 00000000000000000000000000001110]=32'd0; // lw $t3,0($s1) 
Instruction_Memory[32'b 00000000000000000000000000001111]=32'd0; // lw $t3,0($s1) 
Instruction_Memory[32'b 00000000000000000000000000010000]=32'd0; // lw $t3,0($s1) 
Instruction_Memory[32'b 00000000000000000000000000010001]=32'b00000001001010110101100000100100; //and $t3,$t2,$t3

Instruction_Memory[30]=32'b00000001010010010100100000100100; // and $t1,$t2,$t1
end


 always@(address)
  begin
Instruction_Memory[32'b00000000000000000000000000000001]=32'b00000000000000000000000000000001;
 temp= address >> 2;
 //instruction =32'b 00000000000000000000000000000100;
 instruction=Instruction_Memory[temp];
 opCode =instruction[31:26];
 rs =instruction[25:21];
 rt =instruction[20:16];
 rd =instruction[15:11];
 constant =instruction[15:0];
  end
endmodule

module t_test();
wire[31:0] instruction_t;
wire[5:0] OpCode_t;
wire[4:0] rs_t,rt_t,rd_t;
wire[15:0] constant_t;
reg[31:0] address_t;
InstructionMemory m1(instruction_t,OpCode_t,rs_t,rt_t,rd_t,constant_t,address_t);

initial
begin
address_t=32'b00000000000000000000000000000001;
$monitor("%b",instruction_t);
end

endmodule
module IFID (output reg [31:0] PCinc 
, output reg [31:0] instruction
,input [63:0] ifId,input clk,output reg[5:0]opCode,
output reg [4:0] rs,rt,rd,output reg [15:0] constant);

initial 
begin
PCinc=32'd0;
instruction=32'd0;
rs=5'd0;
rt=5'd0;
rd=5'd0;
constant=16'd0;
end


always @(posedge clk)
begin
PCinc <= ifId[63:32];
instruction <= ifId[31:0];
opCode <=instruction[31:26];
 rs <=instruction[25:21];
 rt <=instruction[20:16];
 rd <=instruction[15:11];
 constant <=instruction[15:0];
 end
endmodule
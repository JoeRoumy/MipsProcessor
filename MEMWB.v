module MEMWB( output reg [31:0] alu,output reg [31:0] memoryRead,
output reg [4:0] rd,output reg wb1,wb0,
input[70:0] memWb,input clk);

initial
begin
alu=0;
memoryRead=0;
rd=0;
wb1=0;
wb0=0;
end

always @(posedge clk)
begin

alu <= memWb[70:39];
memoryRead <= memWb[38:7];
rd <= memWb[6:2];
wb1 <= memWb[1];
wb0 <= memWb[0];

end
endmodule
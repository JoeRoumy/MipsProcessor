module IDEX(output reg [31:0] PCinc , output reg [31:0] read1,
output reg [31:0] read2,offset ,output reg [4:0] offsets,output reg [4:0] rd,output reg [4:0] rt,rs,
output reg [1:0] wb,output reg [2:0] mem,output reg exe3,exe2,exe1,exe0,
input [151:0] idEx,input clk);


initial
begin
PCinc=32'd0;
read1=32'd0;
read2=32'd0;
offset=32'd0;
offsets=5'd0;
rd=5'd0;
rt=5'd0;
rs=5'd0;
wb=0;
mem=0;
exe3=0;
exe2=0;
exe1=0;
exe0=0;
end




always @(posedge clk)
begin
rs   <= idEx[151:147];
PCinc <= idEx[146:115];
read1 <= idEx[114:83];
read2 <= idEx[82:51];
offset <= idEx[50:19];
offsets <= idEx[23:19];
rd <= idEx[18:14];
rt <= idEx[13:9];
wb <= idEx[8:7];
mem <= idEx[6:4];
exe3 <= idEx[3];
exe2 <= idEx[2];
exe1 <= idEx[1];
exe0 <= idEx[0];

end
endmodule

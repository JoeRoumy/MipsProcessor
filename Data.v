module data(clk,address,write_data,memCtrl,read_data);
input clk;
input [2:0] memCtrl;
input [31:0] address,write_data;
output reg [31:0]read_data;
reg [31:0] varss[2047:0];
wire mem_Read = memCtrl[2],mem_write = memCtrl[1];

initial
begin
read_data=0;
end


always@(negedge clk)
begin 
if(mem_Read)
read_data=varss[address];
else
begin
if(mem_write)
varss[address]=write_data;
end
end
endmodule


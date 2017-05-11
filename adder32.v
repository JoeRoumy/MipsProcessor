module adder32(branch,pc,shifted);
input [31:0] pc;
input [31:0] shifted;
output reg[31:0] branch;

initial
begin
branch=32'd0;
end
always @(pc or shifted)
begin
branch = pc + shifted;
end
endmodule

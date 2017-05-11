module adder4(new,old);
input [31:0] old;
output reg[31:0]new;

initial new=0;

always @(old)
begin
new = old +4;
end
endmodule

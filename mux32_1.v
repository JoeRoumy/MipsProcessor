module mux32_1 (out,a,b,select);
output reg [31:0] out;
input [31:0] a,b;
input select;

initial
begin
 out=32'd0;
end

always @ (*)
begin
if(select==0)
out=a;
else
out=b;
end

endmodule
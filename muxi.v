module muxi (out,a,b,c,select);
output reg [31:0] out;
input [31:0] a,b,c;
input [1:0] select;

initial
begin
out=32'd0;
end

always @ (*)
begin
if(select==2'b00)
out=a;
else
begin
if(select==2'b01)
out=b;
else
out=c;
end

end

endmodule

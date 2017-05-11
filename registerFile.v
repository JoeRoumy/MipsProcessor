module registerFile(rs,rt,rd,dataIn,regWrite,dataOut1,dataOut2,clk);

input [4:0] rs,rt,rd;
input [31:0] dataIn;
input regWrite,clk;

output [31:0] dataOut1,dataOut2;
reg [31:0] dataOut1,dataOut2;
reg [31:0] regFile [31:0];
initial regFile[0]=32'd0;

initial
begin
dataOut1=32'd0;
dataOut2=32'd0;
$monitor("%b %b %b",regFile[9],regFile[10],regFile[11]);
end

initial 
begin
regFile[9]=32'd10; //??$t1
regFile[10]=32'd12; //$t2
regFile[11]=32'd3; //$t3

end

always @(rs or rt)
begin

dataOut1 <=(rs==0)? 32'b0:regFile[rs];
dataOut2 <=(rt==0)? 32'b0:regFile[rt];

end

always @(posedge clk)
begin

if(regWrite)
begin
regFile[rd] <= (rd==0)? 32'b0:dataIn;
end

end

endmodule


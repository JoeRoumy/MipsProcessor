module pcCircuit (output reg [31:0]pc,input  select ,input clk,
input [31:0] branch,input [31:0] adding_wire);


initial begin pc = 32'b00000000000000000000000000101000; end


always@(posedge clk)
begin
		if(select==0)
		begin
		pc<=adding_wire;//assume input coming from header to be implemented feh tarbet al adder aly by3ml PC+4
		end
		else 
		begin
		pc<=branch;//al input aly haygy incase al select b 1 3nd al mux aly abl al PC 
		end
	end



endmodule

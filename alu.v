module alu (aluResult, zero, in1, in2, shiftAmount, aluControl);
output reg  [31:0] aluResult;
output reg zero;
input [31:0] in1, in2;
input [4:0] shiftAmount;
input [3:0] aluControl;

  initial
  begin
  aluResult=0;
  zero=0;
  end
  
 /* EDITTED!!
  //0 lw sw 			ADD
  //1 add/addi			ADD
  //2 sub				SUB
  //3 and/andi			AND
  //4 or/ori			OR
  //5 sll				SHL
  //6 srl				SHR
  //7 beq				BEQ
  //8 bne				BNE
  //9 slt				SLT
 */
  
always @ (in1,in2)
begin
  case(aluControl)
  4'b0000:aluResult=in1+in2;
  4'b0001:aluResult=in1+in2;
  4'b0010:aluResult=in1-in2;
  4'b0011:aluResult=in1&in2;
  4'b0100:aluResult=in1|in2;
  4'b0101:aluResult=in1<<shiftAmount;
  4'b0110:aluResult=in1>>shiftAmount;
  4'b0111:zero=(in1==in2)? 1:0;
  4'b1000:zero=(in1==in2)? 0:1;
  4'b1001:aluResult=(in1<in2)? 32'd1:0;
  default: begin aluResult=32'd0; zero=0; end
  endcase
  
end
  
 
endmodule


/*

module test();

reg[31:0] in1,in2;
reg[3:0] aluControl;

wire [31:0] aluResult;
wire zero;


initial begin
in1=10;
in2=10;
aluControl=9;

#10 $display ("the result is %b", aluResult); $display("flag %d",zero);

end



alu  testalu (aluResult, zero, in1, in2, aluControl);
endmodule*/


module forwarding(input EXMEMRegWrite,MEMWBRegWrite,input [4:0] EXMEMRd,MEMWBRd,IDEXRs,IDEXRt,output reg[1:0] ForwardA,ForwardB);

initial

begin
ForwardA=2'd0;
ForwardB=2'd0;
end

always@(EXMEMRegWrite,MEMWBRegWrite, EXMEMRd,MEMWBRd,IDEXRs,IDEXRt)
begin
if(EXMEMRegWrite&&(EXMEMRd!=0)&&(EXMEMRd==IDEXRs))
ForwardA=2'b10;

if(EXMEMRegWrite&&(EXMEMRd!=0)&&(EXMEMRd==IDEXRt))
ForwardB=2'b10;

else
begin
if(MEMWBRegWrite&&(MEMWBRd!=0)&&(MEMWBRd==IDEXRs)&&!(EXMEMRd==IDEXRs))
ForwardA=2'b01;
 
if(MEMWBRegWrite&&(MEMWBRd!=0)&&(MEMWBRd==IDEXRt)&&!(EXMEMRd==IDEXRt))
ForwardB=2'b01;


else
begin
ForwardA=2'b00;
ForwardB=2'b00;
end
end
end


endmodule
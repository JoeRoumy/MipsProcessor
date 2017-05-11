module clock(output reg clock);

initial
begin
clock = 1'b0;
forever
#5 clock =~clock;
end

endmodule
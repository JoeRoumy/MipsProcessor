module signExtend (sixteenBit,thirtyTwoBit);
output[31:0] thirtyTwoBit;
input [15:0] sixteenBit;


assign thirtyTwoBit = (sixteenBit[15]==0)? {16'h0,sixteenBit}:{16'hffff,sixteenBit};

endmodule

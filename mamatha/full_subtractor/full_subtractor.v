module full_subtractor(a,b,bin,diff,bout);
input a,b,bin;
output diff,bout;
assign diff=a^b^bin;
assign bout=(~a&b)|(~a&bin)|(b&bin);
endmodule


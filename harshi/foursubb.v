module full_subtractor(a,b,bin,diff,bout);

input a;
input b;
input bin;
output diff;
output bout;

assign diff = a ^ b ^ bin;
assign bout = (~a & b) | (~a & bin) | (b & bin);

endmmodule

module foursubb(a,b,bin,diff,bout);

input [3:0] a;
input [3:0] b;
input bin;
output [3:0] diff;
output bout;

wire b1,b2,b3;

full_subtractor
fs0(a[0],b[0],bin,diff[0],b1);
full_subtractor
fs1(a[1],b[1],b1,diff[1],b2);
full_subtractor
fs2(a[2],v[2],b2,diff[2],b3);
full_subtractor
fs3(a[3],b[3],b3,diff[3],bout);

endmodule




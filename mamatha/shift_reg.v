module shift_reg(clk,reset,dir,serial_in,q);
input clk,reset,dir,serial_in;
output [7:0]q;
reg [7:0]D;
always@(*)
begin
if(dir)
D={q[6:0],serial_in};
else
D={serial_in,q[7:1]};
end
genvar i;
generate
for(i=0;i<8;i=i+1)
begin
dff dff(
.D(D[i]),
.clk(clk),
.set(1'b0),
.reset(reset),
.q(q[i]));
end
endgenerate
endmodule



module register_bank (
input clk,
input we,
input re,
input [2:0] addr,
input [7:0] din,
output reg [7:0] dout
);

ref [7:0] mem [0:7]

always @(posedge clk) begin
if (we)
mem [addr] <= din;
end

always @(*) begin
if (re)
dout = mem [addr];
else
dout = 8'b0;
end 
endmodule

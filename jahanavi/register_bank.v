module register_bank(
input clk,
input we,
input [2:0] addr,
input [7:0] din,
output [7:0] dout
);

reg [7:0] reg_bank [0:7];
always @(posedge clk) begin
if (we)
reg_bank[addr] <= din;
end

assign dout = reg_bank[addr];

endmodule

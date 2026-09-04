module memory_16x32(
input clk,
input reset,
input we,
input [4:0]address,
input[15:0]data_in,
output[15:0] data_out
);

wire[7:0] data_out_low;
wire[7:0] data_out_high;


memory_8x32 mem_low(
.clk(clk),
.reset(reset),
.we(We),
.address(address),
.data_in(data_in[7:0]),
.data_out(data_out_low)
);

memory_8x32 mem_high(
.clk(clk),
.reset(reset),
.we(we),
.address(address),
.data_in(data_in[15:8]),
.data_out(data_out_high)
);

assign data_out={data_out_high, data_out_low};
endmodule


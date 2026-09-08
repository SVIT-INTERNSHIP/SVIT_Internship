module i2c_slave_ip (
input clk,
input reset,
input [6:0] received_addr,
input check_addr_flag,
output ack_bit
);

wire address_ack;

i2c_slave_address_matcher u_address_matcher (
.clk(clk),
.reset(reset),
.received_addr(received_addr),
.check_addr_flag(check_addr_flag),
.ack_bit(address_ack)
);

assign ack_bit = address_ack;
endmodule

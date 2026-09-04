module i2c_master(
input wire clk,
input wire rst_n,
input wire rx_enable,
input wire sda,
output reg scl,
output reg [7:0] rx_reg,
output reg done
);

localparam IDLE = 2'b00;
localparam READ = 2'b01;
localparam DONE = 2'b10;

reg [1:0] state;
reg [7:0] clk_divider;
reg [2:0] bit_cnt;

localparam CLK_DIV_LIMIT = 8'd2;

always@(posedge clk or negedge rst_n) begin
if (!rst_n) begin
state <= IDLE;
scl <= 1'b1;
clk_divider <= 8'd0;
bit_cnt <= 3'd0;
rx_reg <= 8'd0;
done <= 1'b0;
end
else begin
done <= 1'b0;
case (state)
IDLE: begin
scl <= 1'b1;
if (rx_enable) begin
state <= READ;
clk_divider <= 8'd0;
bit_cnt <= 3'd7;
rx_reg <= 8'd0;
end
end

READ: begin
if (clk_divider == (CLK_DIV_LIMIT - 1)) 
begin
clk_divider <= 8'd0;
scl <= ~scl;

if (scl == 1'b0)
begin
rx_reg <= {rx_reg[6:0], sda};

if (bit_cnt == 3'd0) begin
state <= DONE;
end 
else begin
bit_cnt <= bit_cnt - 1'b1;
end
end 
end else begin 
clk_divider <= clk_divider + 1'b1;
end
end

DONE: begin
scl <= 1'b1;
done <= 1'b1;
state<= IDLE;
end

default: state <= IDLE;
endcase
end
end
endmodule

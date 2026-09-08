module i2c_master #(parameter CLK_DIV = 4
)(
input wire clk,input wire rst_n,input wire start_i,
input wire [6:0] slave_addr,input wire rw,output reg scl,inout wire sda,
output reg busy,output reg done);

localparam IDLE = 3'd0,START = 3'd1,SHIFT = 3'd2,ACK = 3'd3,STOP = 3'd4,
FIN = 3'd5;

reg [2:0] state;
reg [3:0] bit_idx;
reg [7:0] shift_reg;
reg       sda_out;
reg	  sda_oe;
integer half_cnt;

assign sda = sda_oe ? sda_out : 1'bz;

always @(posedge clk or negedge rst_n) begin
if (!rst_n) begin
state <= IDLE;
scl <= 1'b1;
sda_out <= 1'b1;
sda_oe <= 1'b1;
half_cnt <= 0;
bit_idx <= 4'd0;
shift_reg <= 8'h00;
busy <= 1'b0;
done <= 1'b0;
end else begin
done <= 1'b0;

case (state)
IDLE: begin
scl <= 1'b1;
sda_out <= 1'b1;
sda_oe <= 1'b1;
half_cnt <= 0;

if (start_i) begin
busy <= 1'b1;
shift_reg <= {slave_addr, rw};
bit_idx <= 4'd7;
state <= START;
end
end

START: begin
if (half_cnt == 0)
sda_out <= 1'b0;

if (half_cnt == CLK_DIV-1) begin
half_cnt <= 0;
scl <= 1'b0;
state <= SHIFT;
end else
half_cnt <= half_cnt + 1;
end

SHIFT: begin
if (half_cnt == 0) begin
sda_out <= shift_reg[bit_idx];
scl <= 1'b0;
end

if (half_cnt == CLK_DIV)
scl <= 1'b1;

if (half_cnt == 2*CLK_DIV-1) begin
half_cnt <= 0;
if (bit_idx == 0)
state <= ACK;
else
bit_idx <= bit_idx - 1'b1;
end else
half_cnt <= half_cnt + 1;
end

ACK: begin
if (half_cnt == 0) begin
sda_oe <= 1'b0;
scl <= 1'b0;
end

if (half_cnt == CLK_DIV)
scl <= 1'b1;

if (half_cnt == 2*CLK_DIV-1) begin
half_cnt <= 0;
sda_oe <= 1'b1;
sda_out <= 1'b0;
scl <= 1'b0;
state <= STOP;
end else
half_cnt <= half_cnt + 1;
end



STOP: begin
if (half_cnt == 0) begin
sda_out <= 1'b0;
scl <= 1'b0;
end

if (half_cnt == CLK_DIV)
scl <= 1'b0;

if (half_cnt == CLK_DIV + CLK_DIV/2)
sda_out <= 1'b1;


if (half_cnt == 2*CLK_DIV-1) begin
half_cnt <= 0;
state <= FIN;
end else

half_cnt <= half_cnt + 1;

end

FIN: begin
busy <= 1'b0;
done <= 1'b1;
state <= IDLE;
end
default: state <= IDLE;
endcase
end
end
endmodule


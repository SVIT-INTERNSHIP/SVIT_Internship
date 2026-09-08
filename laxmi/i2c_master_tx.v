module i2c_master_tx(input wire clk,input wire rst_n,
input wire tx_start,input wire[7:0] tx_data,
input wire scl,output wire sda,
output reg tx_busy,output reg tx_done);
 reg [7:0] tx_shift_reg;

reg [7:0] bit_count;
reg sda_drive_low;
assign sda=sda_drive_low?1'b0:1'bz;

always @(posedge scl or negedge rst_n) begin
if(!rst_n) begin
tx_shift_reg <=8'h00;
bit_count <=4'd0;
tx_busy <=1'b0;
tx_done <=1'b0;
sda_drive_low <=1'b0;
end
else begin
tx_done<=1'b0;

if(tx_start && !tx_busy)
begin
tx_shift_reg <=tx_data;
bit_count <=4'd0;
tx_busy<=1'b1;
if(tx_data[7]==1'b0)
sda_drive_low<=1'b1;
else
sda_drive_low<=1'b0;
end
else if(tx_busy) begin
if(bit_count <4'd7)
begin
tx_shift_reg<={tx_shift_reg[6:0],1'b0};
bit_count<=bit_count+1'b1;
if(tx_shift_reg[6]==1'b0)
sda_drive_low<=1'b1;
else
sda_drive_low<=1'b0;
end
else begin
tx_busy<=1'b0;
tx_done<=1'b1;
bit_count<=4'd0;
sda_drive_low<=1'b0;
end
end
end
end
endmodule

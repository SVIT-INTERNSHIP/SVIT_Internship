`timescale 1ns/1ps

module mp3_sideinfo(
input clk,
input reset,
input start,
input [31:0] header,
input [255:0] side_info,

output reg done,
output reg error,
output reg [8:0] main_data_begin,
output reg [2:0] private_bits,
output reg [7:0] scfsi,

output reg [11:0] part23_0,part23_1,part23_2,part23_3,
output reg [8:0] big_0,big_1,big_2,big_3,
output reg [7:0] gain_0,gain_1,gain_2,gain_3,
output reg        win_0,
output reg        win_1,
output reg        win_2,
output reg        win_3
);

reg [2:0] state;
reg [7:0] ptr;
reg [1:0] gc;

localparam IDLE=0,HEADER=1,GENERAL=2,GRANULE=3,FINISH=4;

function [31:0] getbits;
input [255:0] d;
input integer p;
input integer w;
begin
getbits=(d<<p)>>(256-w);
end
endfunction

always@(posedge clk or posedge reset) begin

if(reset) begin
state<=IDLE;
ptr<=0;
gc<=0;
done<=0;
error<=0;
end

else begin

case(state)

IDLE:begin
done<=0;
if(start) state<=HEADER;
end

HEADER:begin

if(header[20:19]!=2'b11 ||
header[18:17]!=2'b01)
error<=1;

state<=GENERAL;
end

GENERAL:begin

main_data_begin<=getbits(side_info,0,9);
private_bits<=getbits(side_info,9,3);
scfsi<=getbits(side_info,12,8);

ptr<=20;
gc<=0;
state<=GRANULE;

end

GRANULE:begin

case(gc)

0:begin
part23_0<=getbits(side_info,ptr,12);
big_0<=getbits(side_info,ptr+12,9);
gain_0<=getbits(side_info,ptr+21,8);
win_0<=getbits(side_info,ptr+34,1);
end

1:begin
part23_1<=getbits(side_info,ptr,12);
big_1<=getbits(side_info,ptr+12,9);
gain_1<=getbits(side_info,ptr+21,8);
win_1<=getbits(side_info,ptr+34,1);
end

2:begin
part23_2<=getbits(side_info,ptr,12);
big_2<=getbits(side_info,ptr+12,9);
gain_2<=getbits(side_info,ptr+21,8);
win_2<=getbits(side_info,ptr+34,1);
end

3:begin
part23_3<=getbits(side_info,ptr,12);
big_3<=getbits(side_info,ptr+12,9);
gain_3<=getbits(side_info,ptr+21,8);
win_3<=getbits(side_info,ptr+34,1);
end

endcase

ptr<=ptr+59;

if(gc==3)
state<=FINISH;
else
gc<=gc+1;
end

FINISH:begin
done<=1;
state<=IDLE;
end

endcase
end
end

endmodule  

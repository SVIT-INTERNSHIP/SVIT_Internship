module enc(input clk,rst,valid,flush,input[3:0]pcm,output reg out_v,output reg[7:0]b_out,output reg[5:0]cnt);
reg[2:0]c,l; reg[63:0]b;
always@(*)case(pcm)0:begin c=1;l=1;end 1:begin c=1;l=2;end 2:begin c=1;l=3;end default:begin c=0;l=0;end endcase
wire[2:0] m=c&((1<<l)-1);
always@(posedge clk or posedge rst)
if(rst)begin b<=0;cnt<=0;b_out<=0;out_v<=0;end
else begin out_v<=0;
if(valid)begin
if((cnt+l)>=8)begin b_out<=((b<<l)|m)>>((cnt+l)-8);b<=((b<<l)|m);cnt<=(cnt+l)-8;out_v<=1;end
else begin b<=(b<<l) |m;cnt<=cnt+l;end
end else if(flush&&cnt>0)begin b_out<=b<<(8-cnt);b<=0;cnt<=0;out_v<=1;end
end
endmodule

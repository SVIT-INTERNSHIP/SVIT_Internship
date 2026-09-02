module counter(input clk,input reset,input enable,input up_down,output reg[3:0] count);
always @(posedge clk) begin
	if(reset)
		count<=4'b0000;
	else if(enable) begin
		if(up_down)
			count<=count+1'b1;
		else
			count<=count-1'b1;
	end
end
endmodule

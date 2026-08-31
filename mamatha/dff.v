module dff(
	input D,
	input clk,
	input set,
	input reset,
	output reg q);

always @(posedge clk or posedge set or posedge reset)
begin
	if(reset)
	q<=1'b0;
	else if(set)
	q<=1'b1;
	else
	q<=D;
end
endmodule
